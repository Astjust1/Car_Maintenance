//
//  ViewController.swift
//  Mom's
//
//  Created by Armond St.Juste on 5/11/17.
//  Copyright © 2017 Me. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var oilChange: UIDatePicker!
    
    @IBOutlet weak var oilChangeLabel: UILabel!
    //MARK: Actions
    
    @IBAction func oilChangeSubmit(_ sender: Any) {
        
    Utils.addEventToCalendar(title: "Oil Change Time", description: "Oil change time", monthsToExtend: 3, date: oilChange.date as NSDate);
        //Utils.eventsInStore()
    

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Utils.requestAccess()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // DispatchQueue.main.sync{
           // Utils.setup(controller: self)
       // }
    }

}

class BrakeController : UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var brakeLabel: UILabel!
    
    @IBOutlet weak var brakeDate: UIDatePicker!
    
    //MARK: Actions
    
    @IBAction func brakeSubmit(_ sender: Any) {
        
        Utils.addEventToCalendar(title: "Time to change your brakes", description: "Brake maintenance", monthsToExtend: 6, date: brakeDate.date as NSDate)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class FluidsController : UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var fluidsLabel: UILabel!
    
    
    @IBOutlet weak var fluidsDate: UIDatePicker!
    
    //MARK: Actions
    
    @IBAction func fluidsSubmit(_ sender: Any) {
        
        Utils.addEventToCalendar(title: "Time to check your fluids", description: "Check your fluids! Transmission, brake, wipers, etc..", monthsToExtend: 3, date: fluidsDate.date as NSDate)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
