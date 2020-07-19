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
    var gekozenVoertuig = Jtransports()
    var listOfMeeting = [Jmeetingen]()
    var meetingen: [String] = []
     
    //functions
    public override func viewDidLoad()->Void{
        super.viewDidLoad()
       
 
        //set up picker
       
    //init testers
   // print("okeoke")
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
        let nieuwe = meeting( datum: dateMeeting.date, IDvoertuig : gekozenVoertuig.id , km: (akm as NSString).doubleValue , verbruikte: (al as NSString).doubleValue)
         let nieuweuploadable = Uplaodmeeting(IDvervoer: gekozenVoertuig.id, km: (akm as NSString).doubleValue, verbruik: (al as NSString).doubleValue)
        let adder = addMeetingRequest(m: nieuweuploadable)
        
        updategemiddelde(al: nieuwe.verbruikte ,km: (akm as NSString).doubleValue)
        
         
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    func updategemiddelde(al: Double , km : Double ){
           var gem: Double = 0
                         
                         do{
                           let mRequest = MeetingByIdRequest(id:self.gekozenVoertuig.id)
                           mRequest.getMeeting{[weak self] result in
                                 switch result{
                                 case .failure(let error):
                                     print(error)
                                 case .success(let me):
                               self!.listOfMeeting = me
                                     for m in self!.listOfMeeting{
                                        //print("gem voor " + String(gem) + "verbruik " + String(m.verbruik))
                                         gem = gem + m.verbruik
                                       
                                        print("gem na " + String(gem))
                                  }
                                 }
                            gem = (gem + al) / Double(self!.listOfMeeting.count + 1 )
                            print("okeoke gem " +  String(gem))
                            self!.gekozenVoertuig.gemverbruik=gem
                            self!.gekozenVoertuig.km =  self!.gekozenVoertuig.km + km
                            let utr : updateTransportRequest = updateTransportRequest()
                            
                            utr.uploadTransport(n: self!.gekozenVoertuig)
                           }
                          }catch{
                              // pop up ?
                              print("Error , no item in database")
                                }
    
                        
    
    
                   
    
                     }

    
}
