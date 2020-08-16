//
//  CurrencyViewController.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import UIKit

protocol CurrencyViewControllerUseCase: AnyObject {
    func updateExchangeRatesTableView()
    func updateCurrencyPicker()
}

class CurrencyViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var exchangeRatesTableView: UITableView!

    let presenter = CurrencyPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.view = self
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func setupUI() {
        setupTableView()
        setupPickerView()
        setupButton()
    }

    private func setupTableView() {
        exchangeRatesTableView.dataSource = self
    }

    private func setupPickerView() {
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        currencyPickerView.isHidden = true
    }

    private func setupButton() {
        currencyButton.setTitle("Done", for: .selected)
    }

    @IBAction func currencyButtonDidClick(_ sender: Any) {

        let shouldShowPicker = currencyPickerView.isHidden
        if shouldShowPicker {
            currencyButton.isSelected = true
            currencyPickerView.isHidden = false
        } else {
            currencyButton.isSelected = false
            currencyPickerView.isHidden = true
            let selectedIndex = currencyPickerView.selectedRow(inComponent: 0)
            currencyButton.setTitle(presenter.currencies?[selectedIndex].key, for: .normal)
        }
    }
    
}

extension CurrencyViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
    }
}

extension CurrencyViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.currencies?[row].name
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1

    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let currencies = presenter.currencies {
            return currencies.count
        } else {
            return 0
        }
    }
}

extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let exchangeRates = presenter.changeRateResults {
            return exchangeRates.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRatesTableViewCell") as? ExchangeRatesTableViewCell,
            let exchangeRate = presenter.changeRateResults else {
            return UITableViewCell()
        }

        cell.currencyLabel.text = exchangeRate[indexPath.row].currency
        cell.exchangeRateLabel.text = String(exchangeRate[indexPath.row].value)
        return cell
    }


}

extension CurrencyViewController: CurrencyViewControllerUseCase {
    func updateExchangeRatesTableView() {
        exchangeRatesTableView.reloadData()
    }

    func updateCurrencyPicker() {
        currencyPickerView.reloadAllComponents()
    }


}

