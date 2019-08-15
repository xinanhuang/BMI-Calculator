//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Xinan Huang on 8/9/19.
//  Copyright © 2019 Xinan Huang. All rights reserved.
//


/// NOTE:: need to fix pickerview stuff

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {

    
    var weight: Float = 0
    var height: Float = 0
    var BMI:    Float = 0
    var chosenunit_w: String = "kg"
    var chosenunit_h: String = "m"
    
    let WeightUnit = ["kg", "lb"]
    let HeightUnit = ["m", "ft"]
    @IBOutlet weak var BMI_label: UILabel!
    @IBOutlet weak var Result_str: UILabel!
    @IBOutlet weak var WeightInput: UITextField!
    @IBOutlet weak var HeightInput: UITextField!
    @IBOutlet weak var WeightUnitPick: UIPickerView!
    @IBOutlet weak var HeightPickView: UIPickerView!
    
    // main view, also set input textfield to exit keyboard when hit return
    override func viewDidLoad() {
        super.viewDidLoad()
        WeightInput.delegate = self
        HeightInput.delegate = self
        WeightUnitPick = UIPickerView()
        
        WeightUnitPick.dataSource = self
        WeightUnitPick.delegate = self
        
        WeightUnitPick.inputView = WeightUnit
        WightUnitPick.text = WeightUnit.[0]
    }

    
    /// picker view stuff
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return WeightUnit.count
        //return HeightUnit.count
        
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return WeightUnit[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        chosenunit_w = WeightUnit[row]
        self.view.endEditing(true)
    }


    ///////
    
    
    
    // get BMI and update labelfield depending on the BMI Range
    @IBAction func CalculateTrig(_ sender: Any) {
        // make sure both textfield are entered
        if !(WeightInput.text!).isEmpty && !(HeightInput.text!).isEmpty{
            
            weight = Float(WeightInput.text!)!
            height = Float(HeightInput.text!)!
            
            BMI = BMIcalc(weight: weight, height:height)
            if BMI > 30{
                Result_str.text = "Sir McWhale"
            }
            else if BMI < 30 && BMI > 25{
                Result_str.text = "Ooh, fat"
            }
            else if BMI < 25 && BMI > 18.5{
                Result_str.text = "Average Joe"
            }
            else{
                Result_str.text = "Skinny Timmy"
            }
        }
        
    }
    
    
    // calculate BMI and update the label field
    func BMIcalc(weight: Float, height: Float) -> Float{
        
        var BMI: Float = 0
        BMI = weight/(height*height)
        
        var shotenedBMI = String(format: "%.2f", BMI) // alternative way of round to two significant figure after decimal point
        
        BMI_label.text = "Your BMI is \((BMI*100.0).rounded()/100)"
        
        return BMI
    }
    
    
    // allow return key send true signal for exit
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        WeightInput.resignFirstResponder()
        HeightInput.resignFirstResponder()
        return true
    }
    
    //MARK - UITextField Delegates, limit the character input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField ==  HeightInput || textField ==  WeightInput {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789.")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    

}

