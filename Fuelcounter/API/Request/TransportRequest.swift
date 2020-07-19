//
//  TransportRequest.swift
//  Fuelcounter
//
//  Created by Nelson on 08/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation
enum GetError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct TransportRequest{
    let resourceURL:URL
    init(){
         let resourceString = "http://localhost:5000/api/Transport" // later \(var) voor generiek te maken
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }//hier dan de keuze var zetten in meetegeven parameters
    
    func getTransport( completion: @escaping(Result<[Jtransports],GetError>)->Void){
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data,_,_ in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            do{

                let decoder = JSONDecoder()
                let TransportRes = try decoder.decode([Jtransports].self, from: jsonData)
                //let transportdetails = TransportRes.respons
                completion(.success(TransportRes))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
   
    
    
}

class addTransportRequest{
    /*
    @State private var confirmationMessage=""
    @State private var showingConfrmation = false*/
    var nieuwe : Uplaodtransports = Uplaodtransports()
    
    init(n:Uplaodtransports){
        self.nieuwe = n
    }
    init(){
    }
    
    public func addTransport(n:Uplaodtransports){
          guard let encoded = try? JSONEncoder().encode(n)
            else{
                print("Failed to encode Transport")
                return
        }
       
        
        var resourceString:String = "http://localhost:5000/api/Transport/add?" // later \(var) voor generiek te maken
               resourceString = resourceString + "naam=" + n.naam + "&"
               resourceString = resourceString + "km=" + String(n.km) + "&"
               resourceString = resourceString + "gemverbruik=" + String(n.gemverbruik) + "&"
               resourceString = resourceString + "bouwjaar=" + String(n.bouwjaar) + "&"
               resourceString = resourceString + "type=" + n.type + "&"
               resourceString = resourceString + "merk=" + n.merk + "&"
               resourceString = resourceString + "model=" + n.model

        print(resourceString)
        let url = URL(string: resourceString.replacingOccurrences(of: " ", with: "%20"))!
        
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        
        URLSession.shared.dataTask(with: request) {
            data,request, error in
            guard let data = data else{
                print("No datat in response:\(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
        }.resume()
        
    }
    
  
    
}
class updateTransportRequest{
    /*
    @State private var confirmationMessage=""
    @State private var showingConfrmation = false*/
    var nieuwe : Jtransports = Jtransports()
    
    init(n:Jtransports){
        self.nieuwe = n
    }
    init(){
    }
    
    public func uploadTransport(n:Jtransports){
        print(n.naam);
       
       // request.httpBody = encoded
        
        var resourceString:String = "http://localhost:5000/api/Transport/put?" // later \(var) voor generiek te maken
       //localhost:5000/api/Transport/put?ID=1&naam=NELSON&km=321&gemverbruik=321&bouwjaar=2019&type=BENZINE&merk=OKE&model=OKE
        resourceString = resourceString + "ID=" + String(n.id) +  "&"
        resourceString = resourceString + "naam=" + n.naam + "&"
        resourceString = resourceString + "km=" + String(n.km) + "&"
        resourceString = resourceString + "gemverbruik=" + String(n.gemverbruik) + "&"
        resourceString = resourceString + "bouwjaar=" + String(n.bouwjaar) + "&"
        resourceString = resourceString + "type=" + n.type + "&"
        resourceString = resourceString + "merk=" + n.merk + "&"
        resourceString = resourceString + "model=" + n.model
        
        print(resourceString)
        let url = URL(string: resourceString.replacingOccurrences(of: " ", with: "%20"))!
        
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        
        
        URLSession.shared.dataTask(with: request) {
            data,request, error in
            guard let data = data else{
                print("No datat in response:\(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
        }.resume()
        
    }
    
  
    
}
