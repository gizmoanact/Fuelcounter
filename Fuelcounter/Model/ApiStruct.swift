//
//  ApiStruct.swift
//  Fuelcounter
//
//  Created by Nelson on 08/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation
struct TransportResponse: Decodable{
    var response:[Jtransports]
}
struct Jtransports:Decodable {
       var id: Int // autogegenereerd maar verplicht
       var naam: String // verplicht
       var km: Double //niet verplicht en boven 999 999 niet interessant dus range van 0 tot 999 999
       var gemverbruik:Double //wordt automatisch berkend
       var bouwjaar:Int //niet verplicht
       var type:String // verplicht
       var merk:String // niet verplicht
       var model:String // niet verplicht
    init(){
        
               self.id = 0
               self.naam = "geen"
               self.km = 0
               self.gemverbruik = 0
               self.bouwjaar = 0
               self.type = "geen"
               self.merk = "geen"
               self.model = "geen"
    }
   
}

struct Uplaodtransports:Codable {
      // var id: Int // autogegenereerd maar verplicht
       var naam: String // verplicht
       var km: Double //niet verplicht en boven 999 999 niet interessant dus range van 0 tot 999 999
       var gemverbruik:Double //wordt automatisch berkend
       var bouwjaar:Int //niet verplicht
       var type:String // verplicht
       var merk:String // niet verplicht
       var model:String // niet verplicht
    
    var controle : Bool
    
    init(){
        
               //self.id = 0
               self.naam = "geen"
               self.km = 0
               self.gemverbruik = 0
               self.bouwjaar = 0
               self.type = "geen"
               self.merk = "geen"
               self.model = "geen"
        self.controle = false
    }
    
    init( naam : String , km :Double , gemverbruik :  Double , bouwjaar :  Int , type : String , merk : String , model : String){
        
        if (naam == "geen" || km == 0 || gemverbruik == 0 || type == "geen" || merk == "geen" || model == "geen"){
            self.controle = false
        }else{
            self.controle = true

        }
               self.naam = naam
               self.km = km
               self.gemverbruik = gemverbruik
               self.bouwjaar = bouwjaar
               self.type = type
               self.merk = merk
               self.model = model
    }
    
    init(transport : Jtransports){
        
        if (transport.naam == "geen" || transport.km == 0 || transport.gemverbruik == 0 || transport.type == "geen" || transport.merk == "geen" || transport.model == "geen"){
                   self.controle = false
               }else{
                   self.controle = true

               }
       
        self.naam = transport.naam
        self.km = transport.km
        self.gemverbruik = transport.gemverbruik
        self.bouwjaar = transport.bouwjaar
        self.type = transport.type
        self.merk = transport.merk
        self.model = transport.model
    }
   
}


struct MeetingResponse: Decodable{
    var response:[Jmeetingen]
}
struct Jmeetingen:Decodable {
       var id: Int // autogegenereerd maar verplicht
       var datum: String // verplicht
       var iDvervoer: Int //niet verplicht en boven 999 999 niet interessant dus range van 0 tot 999 999
       var km:Double //wordt automatisch berkend
       var verbruik:Double //niet verplicht
    init(){
       print("binnen in de init")
               self.id = 0
               self.datum = "Test"
               self.iDvervoer = 0
               self.km = 0
               self.verbruik = 0
          
    }
   
}

struct Uplaodmeeting:Codable {
    
            var datum: Date // verplicht
            var IDvervoer: Int //niet verplicht en boven 999 999 niet interessant dus range van 0 tot 999 999
            var km:Double //wordt automatisch berkend
            var verbruik:Double //niet verplicht
        var controle : Bool
         init(){
                  
                    self.datum = Date()
                    self.IDvervoer = 0
                    self.km = 0
                    self.verbruik = 0
                    self.controle = false
    }
    
    init( IDvervoer : Int , km :Double , verbruik :  Double){
        
        if (km == 0 || verbruik == 0){
            self.controle = false
        }else{
            self.controle = true

        }
               
               self.datum = Date()
               self.IDvervoer = IDvervoer
               self.km = km
               self.verbruik = verbruik
              
    }
    
    /*init(meeting : Jmeetingen){
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2016/10/08 22:31")


        self.datum = Date()
        self.IDvervoer = meeting.iDvervoer
        self.km = meeting.km
        self.verbruik = meeting.verbruik
        self.controle = false
    }*/
   
}
