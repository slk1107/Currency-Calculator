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
        }
    }

    private var exchageRates: [String: Float]?
    private(set) var currentCurrency: String = "USD"
    private(set) var currentNumebr: Float = 1
    weak var view: CurrencyViewControllerUseCase?

    func viewDidLoad() {
        fetchCurrencies()
        fetchExChangeRates()
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

    private func fetchCurrencies() {
        let task = FetchCurrenciesTask()
        task.fetch() { [weak self] currencies in
            guard let self = self else { return }
            self.currencies = currencies
            self.view?.updateCurrencyPicker()
        }
    }

    private func fetchExChangeRates() {
        let task = FetchExchangeRatesTask()
        task.fetch() { [weak self] exchageRates in
            guard let self = self else { return }
            self.exchageRates = exchageRates
            self.view?.updateExchangeRatesTableView()
        }
    }
}
