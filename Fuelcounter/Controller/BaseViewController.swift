//
//  ViewController.swift
//  Fuelcounter
//
//  Created by Nelson on 05/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//

import UIKit
import  SQLite3

public class BaseViewController: UIViewController {

    @IBOutlet var btnexit: UIButton!
    var db : OpaquePointer?

   public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    
    //database
   
    }
    @IBAction func exitclick(_ sender: Any) {
        exit(0)
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let tc = segue.destination as! transportTableViewController
        if (segue.identifier == "nieuweMeeting") {
            tc.volgendeView = "Nieuwemeeting"
        }else if(segue.identifier == "mainTohistory"){
            tc.volgendeView = "TransportNaarHistory"
        }
    }
    @IBAction func test(_ sender: UIButton) {
        getallTransport();
    }
    
}

