//
//  EventViewController.swift
//  Mom's
//
//  Created by Armond St.Juste on 5/12/17.
//  Copyright © 2017 Me. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class EventViewController : UITableViewController{
    
    //MARK Data
    var eventTitles = [EKEvent]()
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // This was put in mainly for my own unit testing
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventTitles.count // Most of the time my data source is an array of something...  will replace with the actual name of the data source
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Note:  Be sure to replace the argument to dequeueReusableCellWithIdentifier with the actual identifier string!
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
        // set cell's textLabel.text property
        cell.textLabel?.text = eventTitles[indexPath.row].title
        // set cell's detailTextLabel.text property
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Utils.requestAccess()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool ){
        super.viewWillAppear(true)
        self.tableView.contentInset = UIEdgeInsetsMake(50,0,0,0)
        self.eventTitles = Utils.buildEventArray()
    }
}
