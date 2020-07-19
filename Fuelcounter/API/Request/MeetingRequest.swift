//
//  MeetingRequest.swift
//  Fuelcounter
//
//  Created by Nelson on 16/07/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation


struct MeetingRequest{
    let resourceURL:URL
    init(){
         let resourceString = "http://localhost:5000/api/Meeting/all" // later \(var) voor generiek te maken
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }//hier dan de keuze var zetten in meetegeven parameters
    
    func getMeeting( completion: @escaping(Result<[Jmeetingen],GetError>)->Void){
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data,_,_ in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            do{

                let decoder = JSONDecoder()
                print(jsonData.count);
                let MeetingRes = try decoder.decode([Jmeetingen].self, from: jsonData)
                //let transportdetails = TransportRes.respons
                completion(.success(MeetingRes))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
   
    
    
}


struct MeetingByIdRequest{
    let resourceURL:URL
    init(id :Int){
         let resourceString = "http://localhost:5000/api/Meeting?id="+String(id) // later \(var) voor generiek te maken
        print(resourceString)
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }//hier dan de keuze var zetten in meetegeven parameters
    
    func getMeeting( completion: @escaping(Result<[Jmeetingen],GetError>)->Void){
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data,_,_ in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            do{

                let decoder = JSONDecoder()
                print(jsonData.count);
                let MeetingRes = try decoder.decode([Jmeetingen].self, from: jsonData)
                //let transportdetails = TransportRes.respons
                completion(.success(MeetingRes))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
   
    
    
}

class addMeetingRequest{
    /*
    @State private var confirmationMessage=""
    @State private var showingConfrmation = false*/
    var nieuwe : Uplaodmeeting = Uplaodmeeting()
    
    init(m:Uplaodmeeting){
        self.nieuwe = m
        addMeeting(m: self.nieuwe)
    }
    init(){
    }
    
    public func addMeeting(m:Uplaodmeeting){
          guard let encoded = try? JSONEncoder().encode(m)
            else{
                print("Failed to encode Transport")
                return
        }
       
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: m.datum)
        
        var resourceString:String = "http://localhost:5000/api/Meeting/add?" // later \(var) voor generiek te maken
        resourceString = resourceString + "datum=" + dateString + "&"
        resourceString = resourceString + "IDvervoer=" + String(m.IDvervoer) + "&"
        resourceString = resourceString + "km=" + String(m.km) + "&"
        resourceString = resourceString + "verbruik=" + String(m.verbruik)

        print(resourceString)
        let url = URL(string: resourceString.replacingOccurrences(of: " ", with: "%20"))!
        
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        //hier ook de transport gemiddelde aanpassen 
        URLSession.shared.dataTask(with: request) {
            data,request, error in
            guard let data = data else{
                print("No datat in response:\(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
        }.resume()
        
    }
    
  
    
}
