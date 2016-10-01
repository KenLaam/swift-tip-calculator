//
//  ViewController.swift
//  Tip Calulator
//
//  Created by Ken Lâm on 9/25/16.
//  Copyright © 2016 Ken Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var symbolCurrency: String = "$"
    var separatorThousand: String = "."
    
    @IBOutlet weak var txtBill: UITextField!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var percentList: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtBill.becomeFirstResponder()
        getLocale()
        calculateTip(NSNull.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocale(){
        let formatter =  NumberFormatter();
        symbolCurrency = formatter.currencySymbol
        separatorThousand = formatter.currencyGroupingSeparator
        print(String(format: "KenK11 %@", separatorThousand))
        
    }
    
    @IBAction func tapMainView(_ sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func calculateTip(_ sender: AnyObject) {
        let percent = [0.1, 0.15, 0.2]
        let bill = (Double) (txtBill.text!) ?? 0
        lblTip.text = String(format: "%@ %.2f", symbolCurrency, bill * percent[percentList.selectedSegmentIndex])
        lblTotal.text = String(format: "%@ %.2f", symbolCurrency, bill * (1+percent[percentList.selectedSegmentIndex]))
    }

}

