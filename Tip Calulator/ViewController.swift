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
    
    @IBOutlet weak var lblGroupFirst: UILabel!
    @IBOutlet weak var lblGroupSecond: UILabel!
    @IBOutlet weak var lblGroupThird: UILabel!
    @IBOutlet weak var lblGroupFourth: UILabel!
    @IBOutlet weak var txtGroupFirst: UILabel!
    @IBOutlet weak var txtGroupSencond: UILabel!
    @IBOutlet weak var txtGroupThird: UILabel!
    @IBOutlet weak var txtGroupFourth: UILabel!
    
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
        self.view.alpha = 0.3
        UIView.animate(withDuration: 0.4, animations: {
            self.view.alpha = 1
        })
        loadConfig()
        checkLastBill()
        calculateTip(NSNull.self)
        txtBill.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadConfig(){
        var count = (Int) (defaults.integer(forKey: keyPercentages))
        if (count == 0){
            count = 3;
            defaults.set(percentages[0], forKey: keyNo[0])
            defaults.set(percentages[1], forKey: keyNo[1])
            defaults.set(percentages[2], forKey: keyNo[2])
            defaults.synchronize()
        } else {
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
    @IBAction func valueStepperChanged(_ sender: AnyObject) {
        view.endEditing(true)
        calculateTip(NSNull.self)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = (Double) (txtBill.text!) ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        let percent = (Float)(percentages[percentList.selectedSegmentIndex]) / 100.0
        print(percent)
        lblTip.text = numberFormatter.string(from: NSNumber(value: (Float)(bill) * percent))
        lblTotal.text = numberFormatter.string(from: NSNumber(value: (Float)(bill) * (1 + percent)))

        txtGroupFirst.text = numberFormatter.string(from: NSNumber(value: (Float)(bill) * (1 + percent) / 3.0))
        txtGroupSencond.text = numberFormatter.string(from: NSNumber(value: (Float)(bill) * (1 + percent) / 4.0))
        txtGroupThird.text = numberFormatter.string(from: NSNumber(value: (Float)(bill) * (1 + percent) / 8.0))
        txtGroupFourth.text = numberFormatter.string(from: NSNumber(value: (Float)(bill) * (1 + percent) / 12.0))
        
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        defaults.set(dateFormatter.string(from: currentDate as Date), forKey: keyDate)
        defaults.set(txtBill.text, forKey: keyLastBill)
        defaults.synchronize()
        
    }

}

