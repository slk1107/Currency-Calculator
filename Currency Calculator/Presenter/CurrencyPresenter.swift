//
//  CurrencyPresenter.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation

class CurrencyPresenter {

    var currencies: [Currency]?
    var changeRateResults: [ExchangeRateResult]? {
        guard let exchageRates = exchageRates,
        let base = exchageRates[currentCurrency] else {
            return nil
        }

        return exchageRates.map {
            let value = $0.value * currentNumebr / base
            return ExchangeRateResult(currency: $0.key, value: value)
        }.sorted { $0.currency < $1.currency }
    }

    private var exchageRates: [String: Float]?
    private var currentCurrency: String = "USD"
    private(set) var currentNumebr: Float = 1
    private var timer: Timer?
    private let fileManager = RateFileManager()
    weak var view: CurrencyViewControllerUseCase?

    func viewDidLoad() {
        setupExchangeRatesFromFile()
        fetchCurrencies()
        fetchExchangeRates()
        view?.updateTextField(number: currentNumebr)
        view?.updateCurrencyButton(title: currentCurrency)
    }

    func viewDidAppear() {
        setupTimer(interval: 30 * 60)
    }

    func viewWillDisappear() {
        stopTimer()
    }

    func numberDidInput(number: Float) {
        currentNumebr = number
        view?.updateExchangeRatesTableView()
    }

    func currencyDidSelect(atIndex index: Int) {
        if let currency = currencies?[index].key,
            currency != currentCurrency {
            currentCurrency = currency
            view?.updateCurrencyButton(title: currency)
            view?.updateExchangeRatesTableView()
        }
    }

    private func setupTimer(interval: TimeInterval) {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: {_ in
            self.fetchExchangeRates()
        })
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func fetchCurrencies() {
        let task = FetchCurrenciesTask()
        task.fetch() { [weak self] currencies in
            guard let self = self else { return }
            self.currencies = currencies
            self.view?.updateCurrencyPicker()
        }
    }

    private func setupExchangeRatesFromFile() {
        exchageRates = fileManager.readRate()
        view?.updateExchangeRatesTableView()
    }

    private func fetchExchangeRates() {
        let task = FetchExchangeRatesTask()
        task.fetch() { [weak self] exchageRates in
            guard let self = self, let exchageRates = exchageRates else { return }
            _ = self.fileManager.saveRate(exchageRates)
            self.exchageRates = exchageRates
            self.view?.updateExchangeRatesTableView()
        }
    }
}
