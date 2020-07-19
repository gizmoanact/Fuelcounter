//
//  voertuigDetailsController.swift
//  Fuelcounter
//
//  Created by Nelson on 20/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation
import UIKit

public class voertuigDetailsController : UIViewController {
   
    //view items
   
    @IBOutlet var naamlbl: UILabel!
    @IBOutlet var typelbl: UILabel!
    @IBOutlet var kmlbl: UILabel!
    @IBOutlet var gemverlbl: UILabel!
    @IBOutlet var bouwjaarlbl: UILabel!
    
    
    
    var listOfTransport = [Jtransports]()
    
    // variabelen
    var gekozenVoertuig = Jtransports()
    
    //functions
    public override func viewDidLoad()->Void{
        super.viewDidLoad()
        //set up picker
       
    //init testers
   // print("okeoke")
        getTransportsFromApi()
            naamlbl.text =  gekozenVoertuig.naam
            typelbl.text = gekozenVoertuig.type
            kmlbl.text =  String(gekozenVoertuig.km)
            gemverlbl.text = String(gekozenVoertuig.gemverbruik)// haal alle data om gemiddelde te maken
            bouwjaarlbl.text = String(gekozenVoertuig.bouwjaar)

    }
    func getTransportsFromApi(){
        let tRequest = TransportRequest()
        tRequest.getTransport{[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let tr):
                self!.listOfTransport = tr
               // print("perfect")
                print(self!.listOfTransport[0].naam)
            }
            
            
            
            
        }
        
    }
   
    
}
