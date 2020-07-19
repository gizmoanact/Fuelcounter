//
//  historyController.swift
//  Fuelcounter
//
//  Created by Nelson on 18/07/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation
import UIKit

public class historyController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
        
    //view items
   
    @IBOutlet var tableView: UITableView!
    
    
    // variabelen
   var listOfTransport = [Jtransports]()
   var voertuigen: [String] = []
    
    var listOfMeeting = [Jmeetingen]()
     var meetingen: [String] = []
    
    let cellReuseIdentifier = "cell"
   
    //functions
    public override func viewDidLoad()->Void{
        //print("okeoke");
        
        getTransportsFromApi();
        getMeetingenFromApi();
        
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
              tableView.delegate = self
              tableView.dataSource = self
       
        //set up picker
       
    //init testers
    }
  
          func getTransportsFromApi(){
                 do{
                    let tRequest = TransportRequest()
                    tRequest.getTransport{[weak self] result in
                        switch result{
                        case .failure(let error):
                            print(error)
                        case .success(let tr):
                            self!.listOfTransport = tr
                            for t in self!.listOfTransport{
                             //print("oke" + t.naam)
                             self!.voertuigen.append(t.naam )
                         }
                        }
                        
         }

                 }catch{
                     // pop up ?
                     print("Error , no item in database")
                 }
             }

    func getMeetingenFromApi(){
                   do{
                      let mRequest = MeetingRequest()
                    mRequest.getMeeting{[weak self] result in
                          switch result{
                          case .failure(let error):
                              print(error)
                          case .success(let me):
                        self!.listOfMeeting = me
                              for m in self!.listOfMeeting{
                                print("oke" + String(m.IDvervoer))
                                self!.meetingen.append(String(m.IDvervoer) )
                                   self!.tableView.reloadData()
                           }
                          }
                    }
                   }catch{
                       // pop up ?
                       print("Error , no item in database")
                   }
               }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.voertuigen.count
       }
    
         public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

             // create a new cell if needed or reuse an old one
         let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell as UITableViewCell


             cell.textLabel?.text = self.voertuigen[indexPath.row]

             return cell
         }
    
}


   
