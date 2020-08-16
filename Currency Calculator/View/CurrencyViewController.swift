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
    func updateCurrencyButton(title: String)
    func updateTextField(number: Float)
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
    }

    override func viewDidAppear(_ animated: Bool) {
        presenter.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        presenter.viewWillDisappear()
    }

    private func setupUI() {
        setupTableView()
        setupPickerView()
        setupButton()
        setupTextField()
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

    private func setupTextField() {
        inputTextField.text = "1"
        inputTextField.delegate = self
    }

    @IBAction func currencyButtonDidClick(_ sender: Any) {
        dismissKeyboardIfNeed()

        let shouldShowPicker = currencyPickerView.isHidden
        if shouldShowPicker {
            currencyButton.isSelected = true
            currencyPickerView.isHidden = false
        } else {
            currencyButton.isSelected = false
            currencyPickerView.isHidden = true
            let selectedIndex = currencyPickerView.selectedRow(inComponent: 0)
            presenter.currencyDidSelect(atIndex: selectedIndex)
        }
    }

    private func dismissKeyboardIfNeed() {
        inputTextField.resignFirstResponder()
    }
}

extension CurrencyViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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

        let value = exchangeRate[indexPath.row].value
        let roundValue = round(100 * value)/100
        cell.exchangeRateLabel.text = String(roundValue)
        return cell
    }
}

extension CurrencyViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let number = Float(text) else {
            return
        }
        presenter.numberDidInput(number: number)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 0 && string == "0" {
            return false
        }
        return string == string.filter("0123456789.".contains)
    }
}

extension CurrencyViewController: CurrencyViewControllerUseCase {
    func updateExchangeRatesTableView() {
        exchangeRatesTableView.reloadData()
    }

    func updateCurrencyPicker() {
        currencyPickerView.reloadAllComponents()
    }

    func updateCurrencyButton(title: String) {
        currencyButton.setTitle(title, for: .normal)
    }

    func updateTextField(number: Float) {
        inputTextField.text = String(number)
    }
}

