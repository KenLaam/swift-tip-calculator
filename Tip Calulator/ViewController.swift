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
    let keyDate = "date"
    let keyInterval = "interval"
    let keyLastBill = "lastBill"
    let dateFormat = "MM-dd-yyyy_HH:mm:ss"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadConfig()
        txtBill.becomeFirstResponder()
        checkLastBill()
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
        // Save last bill
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        defaults.set(dateFormatter.string(from: currentDate as Date), forKey: keyDate)
        defaults.set(txtBill.text, forKey: keyLastBill)
        defaults.synchronize()
        }
    
    func checkLastBill(){
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if((defaults.string(forKey: keyDate)) != nil){
            let lastDate = dateFormatter.date(from: defaults.string(forKey: keyDate)!)
            let different = currentDate.timeIntervalSince(lastDate!)

//        print(String(format: "KenK11 current time %@ \n", dateFormatter.string(from: currentDate as Date)))
//        print(String(format: "KenK11 last time %@ \n", dateFormatter.string(from: lastDate! as Date)))
//        print(String(format: "KenK11 interval time %@ \n", dateComponentsFormatter.string(from: different)!))

            var interval = defaults.double(forKey: keyInterval) * 60
            if (interval == 0 ){
                interval = 600
            }

            if (different.isLessThanOrEqualTo(interval)){
                print("KenK11 True")
                txtBill.text = defaults.string(forKey: keyLastBill)
            } else {
                print("KenK11 False")
                txtBill.text = ""
            }
        }
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = (Float) (txtBill.text!) ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        let percent = Float(percentages[percentList.selectedSegmentIndex]) / 100.0
        
        lblTip.text = numberFormatter.string(from: NSNumber(value: bill * percent))
        lblTotal.text = numberFormatter.string(from: NSNumber(value: bill * (1 + percent)))
    }

}

