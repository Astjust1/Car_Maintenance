//
//  SetupViewController.swift
//  Mom's
//
//  Created by Armond St.Juste on 5/13/17.
//  Copyright © 2017 Me. All rights reserved.
//

import Foundation
import UIKit

class SetupViewController: UIViewController{
    
    //MARK: Properties
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var waitLabel: UILabel!
    
    @IBOutlet weak var doneLabel: UILabel!
    
    //MARK: ACtions
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
        print("Should be requesting permissions")
        var group = DispatchGroup()
        group.enter()
        Utils.requestPermissions(eventStore: Utils.eventStore, controller: self)
        group.leave()
        group.notify(queue: DispatchQueue.main, execute: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
            
                Utils.setup()
                //Hide elements
                self.loadingIndicator.hidesWhenStopped = true
                self.loadingIndicator.stopAnimating()
                self.waitLabel.isHidden = true
                
                //Show Elements
                self.doneLabel.isHidden = false
                self.doneButton.isHidden = false
            
            })
        
        })
        
        
    }
    
    
    
}
