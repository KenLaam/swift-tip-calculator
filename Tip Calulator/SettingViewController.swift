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
    
}
