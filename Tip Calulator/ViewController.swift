//
//  ViewController.swift
//  Tip Calulator
//
//  Created by Ken Lâm on 9/25/16.
//  Copyright © 2016 Ken Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtBill: UITextField!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var percentList: UISegmentedControl!
    
    var defaults  = UserDefaults.standard
    let keyPercentages = "percentages"
    let keyFirst = "firstPercent"
    let keySecond = "secondPercent"
    let keyThird = "thirdPercent"
    let keyFourth = "fourthPercent"
    let keyFifth = "fifthPercent"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtBill.becomeFirstResponder()
        calculateTip(NSNull.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadConfig(){
        var percentages = (Int) (defaults.integer(forKey: keyPercentages))
        if (percentages == 0){
            percentages = 3;
        }
        percentList.removeAllSegments()
//        var index = 0
//        
//        switch percentages {
//        
//        while (index < percentages) {
//            percentList.insertSegment(withTitle: <#T##String?#>, at: index, animated: Bool)
//        }
        
        
        
        
    }
    
    
    
    @IBAction func tapMainView(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let percent = [0.1, 0.15, 0.2]
        let bill = (Double) (txtBill.text!) ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        
        lblTip.text = numberFormatter.string(from: NSNumber(value: bill * percent[percentList.selectedSegmentIndex]))
        lblTotal.text = numberFormatter.string(from: NSNumber(value: bill * (1 + percent[percentList.selectedSegmentIndex])))
    }

}

