//
//  transportTableViewController.swift
//  Fuelcounter
//
//  Created by Nelson on 06/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import Foundation
import UIKit

public class transportTableViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {


  
    var voertuigen: [String] = []
    let cellReuseIdentifier = "cell"

    
    var listOfTransport = [Jtransports]()
   
    @IBOutlet var tableView: UITableView!
    
    var gekozenVoertuig = Jtransports()
    var volgendeView: String = "Geen"
    
    public override func viewDidLoad() {
          getTransportsFromApi();
        super.viewDidLoad()
       
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

    
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

 
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voertuigen.count
    }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell as UITableViewCell


        cell.textLabel?.text = self.voertuigen[indexPath.row]

        return cell
    }

    // method to run when table view cell is tapped
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    tableView.deselectRow(at: indexPath, animated: true)
    gekozenVoertuig = listOfTransport[indexPath.row]
    
    if(volgendeView=="Nieuwemeeting"){
    performSegue(withIdentifier: "transportNaarNieuweMeeting", sender: listOfTransport[indexPath.row])
        
    }else if(volgendeView=="TransportNaarHistory"){
        
    performSegue(withIdentifier: "TransportNaarHistory", sender: listOfTransport[indexPath.row])
       
    }else {
    performSegue(withIdentifier: "voertuigdetails", sender: listOfTransport[indexPath.row])
        }
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "voertuigdetails") {
            //print("okeokoekoekoek")
            let vc = segue.destination as! voertuigDetailsController
            vc.gekozenVoertuig = gekozenVoertuig
        }
        if (segue.identifier == "transportNaarNieuweMeeting") {
                   let ac = segue.destination as! addMetingController
                   ac.gekozenVoertuig = gekozenVoertuig
               }
        if (segue.identifier == "TransportNaarHistory") {
                         let hc = segue.destination as! historyController
                         hc.gekozenVoertuig = gekozenVoertuig
                     }
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
                  // print("perfect")
                  // print(self!.listOfTransport[0].naam)
                let emojiArray = ["🚘","🚖","🛵","🏍","🚲","🛴","🚛","🚚","🚐","🚒","🚑","🚓","🏎","🚎","🚌","🚙","🚕","🚗"]
                   for t in self!.listOfTransport{
                   var number = Int.random(in: 0 ... 18)
                    self!.voertuigen.append(t.naam + emojiArray[number] )
                }
                   self!.tableView.reloadData()
               }
               
}

        }catch{
            // pop up ?
            print("Error , no item in database")
        }
    }
}
