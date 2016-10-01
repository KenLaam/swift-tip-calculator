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
    
    let defaults  = UserDefaults.standard
    @IBOutlet weak var txtPercentages: UILabel!
    @IBOutlet weak var stepperPercentages: UIStepper!
    
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
    
    @IBAction func valueStepperChanged(_ sender: UIStepper) {
        txtPercentages.text = Int(sender.value).description
        saveConfig(key: keyPercentages, value: Int(sender.value))
        displayPercentages(count: Int(sender.value))
    }
    
    func saveConfig(key:String, value:Int){
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    func loadConfig(){
        var percentages = (Int) (defaults.integer(forKey: keyPercentages))
        if (percentages == 0){
            percentages = 3;
        }
        
        txtPercentages.text = String(percentages)
        stepperPercentages.value = (Double) (percentages)
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
    }
    
}
