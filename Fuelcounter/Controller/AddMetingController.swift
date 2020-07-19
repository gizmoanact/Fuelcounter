//
//  addMetingController.swift
//  Fuelcounter
//
//  Created by Nelson on 06/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation
import UIKit

public class addMetingController:UIViewController {
        
    //view items
    @IBOutlet var aantalKmTxtF: UITextField!
    @IBOutlet var aantalLiterTxtF: UITextField!
    @IBOutlet var dateMeeting: UIDatePicker!
    
    // variabelen
    var gekozenVoergtuig = Jtransports()
    
    //functions
    public override func viewDidLoad()->Void{
        super.viewDidLoad()
        aantalLiterTxtF.text = gekozenVoergtuig.naam;
        //set up picker
       
    //init testers
    print("okeoke")
    }

    @IBAction func voegmeetingtoe(_ sender: Any) {
        
        // get date from datepicker
               dateMeeting.datePickerMode = UIDatePicker.Mode.date
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd MMMM yyyy"
               let date = dateFormatter.string(from: dateMeeting.date)
        // hier km door geven en al maar ook gemiddelde maken van nu gehad en gemiddelde !
        
        let akm:String = aantalKmTxtF.text!
        let al:String = aantalLiterTxtF.text!
        
        let nieuwe = meeting( datum: dateMeeting.date, IDvoertuig : gekozenVoergtuig.id , km: (akm as NSString).doubleValue , verbruikte: (al as NSString).doubleValue)
         let nieuweuploadable = Uplaodmeeting(IDvervoer: gekozenVoergtuig.id, km: (akm as NSString).doubleValue, verbruik: (al as NSString).doubleValue)
        let adder = addMeetingRequest(m: nieuweuploadable)
        _ = navigationController?.popToRootViewController(animated: true)
    }
   
         
         
    
}
