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
        guard let exchageRates = exchageRates else {
            return nil
        }

        return exchageRates.map {
            return ExchangeRateResult(currency: $0.key, value: $0.value)
        }
    }
    private var exchageRates: [String: Float]?
    weak var view: CurrencyViewControllerUseCase?

    func viewDidLoad() {
        fetchCurrencies()
        fetchExChangeRates()
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
