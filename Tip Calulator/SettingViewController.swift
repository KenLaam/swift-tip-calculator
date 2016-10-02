//
//  SettingViewController.swift
//  Tip Calulator
//
//  Created by Ken Lâm on 9/25/16.
//  Copyright © 2016 Ken Lam. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    let keyPercentages = "percentages"
    let keyNo = ["firstPercent", "secondPercent", "thirdPercent", "fourthPercent", "fifthPercent"]
    let keyInterval = "interval"
    
    var defaults  = UserDefaults.standard
    @IBOutlet weak var txtPercentages: UILabel!
    @IBOutlet weak var txtInterval: UILabel!
    @IBOutlet weak var stepperPercentages: UIStepper!
    @IBOutlet weak var stepperInterval: UIStepper!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    @IBOutlet weak var txtFirstPercentage: UITextField!
    @IBOutlet weak var txtSecondPercentage: UITextField!
    @IBOutlet weak var txtThirdPercentage: UITextField!
    @IBOutlet weak var txtFourthPercentage: UITextField!
    @IBOutlet weak var txtFifthPercentage: UITextField!
    
    @IBOutlet weak var labelFirstPercentage: UILabel!
    @IBOutlet weak var labelSecondPercentage: UILabel!
    @IBOutlet weak var labelThirdPercentage: UILabel!
    @IBOutlet weak var labelFourthPercentage: UILabel!
    @IBOutlet weak var labelFifthPercentage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadConfig()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func valueStepperIntervalChanged(_ sender: UIStepper) {
        btnSave.isEnabled = true
        txtInterval.text = Int(sender.value).description
    }
    
    @IBAction func valueStepperPercentageChanged(_ sender: UIStepper) {
        btnSave.isEnabled = true
        txtPercentages.text = Int(sender.value).description
        displayPercentages(count: Int(sender.value))
    }
    
    @IBAction func clickSave(_ sender: AnyObject) {
        btnSave.isEnabled = false
        view.endEditing(true)
        saveConfig(key: keyInterval, value: Int(stepperInterval.value))
        saveConfig(key: keyPercentages, value: Int(stepperPercentages.value))
        var index = 1
        var txtField: UITextField
        while(index <= Int(stepperPercentages.value)){
            txtField = self.view.viewWithTag(index) as! UITextField
            saveConfig(key: keyNo[index - 1], value: Int(txtField.text!)!)
            index += 1
        }
    }
    
    @IBAction func valueChanged(_ txtPercent: UITextField) {
        btnSave.isEnabled = true
        let percent = (Int) (txtPercent.text!) ?? 0
        txtPercent.text = String(percent)
    }
    
    
    func saveConfig(key:String, value:Int){
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    func loadConfig(){
        var interval = defaults.integer(forKey: keyInterval)
        if(interval == 0 ){
            interval = 10
        }
        txtInterval.text = String(interval)
        stepperInterval.value = (Double) (interval)

        var percentages = (Int) (defaults.integer(forKey: keyPercentages))
        if (percentages == 0){
            percentages = 3;
        }
        
        txtPercentages.text = String(percentages)
        stepperPercentages.value = (Double) (percentages)
        displayPercentages(count: percentages)
        loadPercentages(count: percentages)
        
    }
    
    func getPercent(key:String) -> String{
        if((defaults.string(forKey: key)) != nil){
            return defaults.string(forKey: key)!
        }
        return "0"
    }
    
    func displayPercentages(count:Int){
        switch count {
        case 2:
            labelThirdPercentage.isHidden = true
            labelFourthPercentage.isHidden = true
            labelFifthPercentage.isHidden = true
            
            txtThirdPercentage.isHidden = true
            txtFourthPercentage.isHidden = true
            txtFifthPercentage.isHidden = true
            break
        case 3:
            labelThirdPercentage.isHidden = false
            labelFourthPercentage.isHidden = true
            labelFifthPercentage.isHidden = true
            
            txtThirdPercentage.isHidden = false
            txtFourthPercentage.isHidden = true
            txtFifthPercentage.isHidden = true
            break
        case 4:
            labelThirdPercentage.isHidden = false
            labelFourthPercentage.isHidden = false
            labelFifthPercentage.isHidden = true
            
            txtThirdPercentage.isHidden = false
            txtFourthPercentage.isHidden = false
            txtFifthPercentage.isHidden = true
            break
        case 5:
            labelThirdPercentage.isHidden = false
            labelFourthPercentage.isHidden = false
            labelFifthPercentage.isHidden = false
            
            txtThirdPercentage.isHidden = false
            txtFourthPercentage.isHidden = false
            txtFifthPercentage.isHidden = false
            break
        default:
            break;
        }
        loadPercentages(count: count)
    }
    
    func loadPercentages(count:Int){
        var index: Int = 1;
        var txtField: UITextField
        while(index <= count){
            txtField = self.view.viewWithTag(index) as! UITextField
            txtField.text = getPercent(key: keyNo[index - 1])
            index += 1
        }
    }
    
}
