//
//  CurrencyViewController.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import UIKit

protocol CurrencyViewControllerUseCase: AnyObject {
    func updateTableView()
    func updatePicker()
}

class CurrencyViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var exchangeRatesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

