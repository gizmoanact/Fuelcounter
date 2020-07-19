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


    // Data model: These strings will be the data for the table view cells
    var voertuigen: [String] = []// = ["Mercedes", "BMW", "Skoda", "Volkswagen", "Audi"] // dit moet gevuld worden met de lijstr van voertuigen
    // vullen als volgd Naam , Model , merk , jaar

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

    
    var listOfTransport = [Jtransports]()
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    var gekozenVoergtuig = Jtransports() // wordt later na db aangepoast zoals de lijst hoierboven met de gekozen it of data
    var volgendeView: String = "Geen"
    
    public override func viewDidLoad() {
          getTransportsFromApi();
        super.viewDidLoad()
       
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    // number of rows in table view
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voertuigen.count
    }

    // create a cell for each table view row
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
    let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell as UITableViewCell


        cell.textLabel?.text = self.voertuigen[indexPath.row]

        return cell
    }

    // method to run when table view cell is tapped
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    tableView.deselectRow(at: indexPath, animated: true)
    gekozenVoergtuig = listOfTransport[indexPath.row]
    if(volgendeView=="Nieuwemeeting"){
    performSegue(withIdentifier: "transportNaarNieuweMeeting", sender: listOfTransport[indexPath.row])
    }else{
    performSegue(withIdentifier: "voertuigdetails", sender: listOfTransport[indexPath.row])
        }
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "voertuigdetails") {
            //print("okeokoekoekoek")
            let vc = segue.destination as! voertuigDetailsController
            vc.gekozenVoergtuig = gekozenVoergtuig
        }
        if (segue.identifier == "transportNaarNieuweMeeting") {
                   let ac = segue.destination as! addMetingController
                   ac.gekozenVoergtuig = gekozenVoergtuig
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
                
                   for t in self!.listOfTransport{
                   // print("oke" + t.naam)
                    self!.voertuigen.append(t.naam )
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
