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
    
    var percentages: [Int] = [10, 15, 20, 25, 30]
    var defaults  = UserDefaults.standard
    let keyPercentages = "percentages"
    let keyNo = ["firstPercent", "secondPercent", "thirdPercent", "fourthPercent", "fifthPercent"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadConfig()
        txtBill.becomeFirstResponder()
        calculateTip(NSNull.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadConfig(){
        var count = (Int) (defaults.integer(forKey: keyPercentages))
        if (count == 0){
            count = 3;
        }
        
        percentList.removeAllSegments()
        var index = 0
        var percent: Int
        var title: String
        
        while (index < count){
            percent = defaults.integer(forKey: keyNo[index])
            title = String(format: "%d%%", percent)
            percentList.insertSegment(withTitle: title, at: index, animated: false)
            percentages[index] = percent
            index += 1
        }
        percentList.selectedSegmentIndex = 0
    }
    
    
    
    @IBAction func tapMainView(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = (Float) (txtBill.text!) ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        let percent = Float(percentages[percentList.selectedSegmentIndex] / 100)
        print(String(format: "KenK11 %.2f %d %d", percent, percentList.selectedSegmentIndex, percentages[percentList.selectedSegmentIndex]))
        lblTip.text = numberFormatter.string(from: NSNumber(value: bill * percent))
        lblTotal.text = numberFormatter.string(from: NSNumber(value: bill * (1 + percent)))
    }

}

