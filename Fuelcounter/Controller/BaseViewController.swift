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

    var db : OpaquePointer?

   public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    
    //database
   
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

