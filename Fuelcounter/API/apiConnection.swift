//
//  apiConnection.swift
//  Fuelcounter
//
//  Created by Nelson on 07/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation

    func getallTransport(){
        let session = URLSession.shared
        let url = URL(string: "http://localhost:5000/api/Transport")!

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

    

