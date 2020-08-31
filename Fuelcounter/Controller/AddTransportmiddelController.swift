//
//  addTransportMiddelController.swift
//  Fuelcounter
//
//  Created by Nelson on 06/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation
import UIKit

public class AddTransportmiddelController:UIViewController {
    
    //view items
    @IBOutlet var naamTxtF: UITextField!
    @IBOutlet var typePicker: UIPickerView!
    @IBOutlet var kmTxtF: UITextField!
    @IBOutlet var merkTxtF: UITextField!
    @IBOutlet var modelTxtF: UITextField!
    @IBOutlet var bouwjaarDatePicker: UIDatePicker!
    @IBOutlet var gemverTxtF: UITextField!
    
    @IBOutlet var naamlbl: UILabel!
    @IBOutlet var typelbl: UILabel!
    @IBOutlet var kmlbl: UILabel!
    @IBOutlet var merklbl: UILabel!
    @IBOutlet var modellbl: UILabel!
    @IBOutlet var datelbl: UILabel!
    
    
    
    // variabelen
    private let pickerDataArray=["-maak een keuze-","andere","bezine","diesel","electrisch","lpg"]
    // let pickerDataArray=["we","gaan","is","testen"]
    //pickerDataArray=[Typevervoer.andere,Typevervoer.bezine,Typevervoer.disel,Typevervoer.electrisch,Typevervoer.lpg]
    var selected : String = " "
   var validation = Validation()
    //functions
    public override func viewDidLoad()->Void{
        super.viewDidLoad()
       
        //set up picker
        typePicker.dataSource = self
        typePicker.delegate = self
    //init testers
    //print("okeoke")
    }

    @IBAction func test(_ sender: Any) {
        
        
    }
    @IBAction func saveNewTransportmiddel(_ sender: UIButton) {
       
       /*
        var type: Typevervoer = Typevervoer.andere
        switch selected {
        case "-maak een keuze -":
         print("hier moet een error scherm komen")
        case "andere":
            type = Typevervoer.andere
        case "bezine":
            type = Typevervoer.bezine
        case "diesel":
            type = Typevervoer.diesel
        case "electrisch":
            type = Typevervoer.electrisch
        case "lpg":
            type = Typevervoer.lpg
        default:
             type = Typevervoer.andere
        }
        
        */
        let naam:String = naamTxtF.text!
        var km:String = kmTxtF.text!
        let merk:String = merkTxtF.text!
        let model:String = modelTxtF.text!
        bouwjaarDatePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let bouwjaar : Int = Int(dateFormatter.string(from: bouwjaarDatePicker.date))!
       // let gemver:String = gemverTxtF.text!
        
        
        let isValidateName = self.validation.validateNaam(naam: naam)
             if (isValidateName == false) {
                //lbl text veranderen
                naamlbl.textColor = UIColor.red
                print("Incorrect Name")
                return
             }
        
        let isValideType = self.validation.validateType(type: selected)
                           if (isValideType == false) {
                               typelbl.textColor = UIColor.red
                              print("Incorrect Type")
                              return
                           }
        
        let isValidateMerk = self.validation.validateNaam(naam: merk)
        if (isValidateMerk == false) {
           //lbl text veranderen
           merklbl.textColor = UIColor.red
           print("Incorrect Merk")
           return
        }
        
        let isValidateModel = self.validation.validateNaam(naam: model)
        if (isValidateModel == false) {
           //lbl text veranderen
            modellbl.textColor = UIColor.red
           print("Incorrect Model")
           return
        }
        
        let isValidateDate = self.validation.validateDate(datum: bouwjaar)
                    if (isValidateDate == false) {
                        datelbl.textColor = UIColor.red
                       print("Incorrect Date")
                       return
                    }
        if(km == "" || km.isEmpty){
            km = "0.0"
        }
       
         
       // if 3 oke dan do anders lbl aanpassen
        
        
        
        let nieuwe =  Uplaodtransports(naam: naam, km: Double(km)!, gemverbruik: 0.0 , bouwjaar: bouwjaar, type: selected, merk: merk, model: model)
        let adder = addTransportRequest()
        adder.addTransport(n: nieuwe)
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
}

//extentions
extension AddTransportmiddelController: UIPickerViewDelegate, UIPickerViewDataSource{
    //view items
    //variabelen
    //func
  public  func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
  public  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataArray.count
    }
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected =  pickerDataArray[row]
    }
    
   public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataArray[row]
    }
    
    
    
    
}
