//
//  CurrencyPresenter.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation

class CurrencyPresenter {

    weak var view: CurrencyViewControllerUseCase?
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
    private let userDefaultManager = UserDefaultManager()
    private let requestInterval: TimeInterval = 30 * 60

    func viewDidLoad() {
        setupExchangeRatesFromFile()
        fetchCurrencies()
        fetchExchangeRatesIfNeed()
        view?.updateTextField(number: currentNumebr)
        view?.updateCurrencyButton(title: currentCurrency)
    }

    func viewDidAppear() {
        setupTimer(interval: requestInterval)
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
            self.fetchExchangeRatesIfNeed()
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

    private func fetchExchangeRatesIfNeed() {
        guard let lastFetchDate = userDefaultManager.getFileSavedTime() else {
            fetchExchangeRates()
            return
        }
        let now = Date.timeIntervalSinceReferenceDate

        if (now - lastFetchDate) > requestInterval {
            fetchExchangeRates()
        }
    }

    private func fetchExchangeRates() {
        let task = FetchExchangeRatesTask()
        task.fetch() { [weak self] exchageRates in
            guard let self = self, let exchageRates = exchageRates else { return }
            _ = self.fileManager.saveRate(exchageRates)
            let time = Date.timeIntervalSinceReferenceDate
            self.userDefaultManager.saveFileSavedTime(sinceRefereceTime: time)
            self.exchageRates = exchageRates
            self.view?.updateExchangeRatesTableView()
        }
    }
}
