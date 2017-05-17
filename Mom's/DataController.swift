//
//  DataController.swift
//  Mom's
//
//  Created by Armond St.Juste on 5/13/17.
//  Copyright © 2017 Me. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject{
    
    static var managedContext:NSManagedObjectContext
   // var persistentContainer:NSPersistentContainer
    
    init(completion: @escaping () -> ()){
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores(){ (description, error) in
            if let error = error{
                fatalError("Failed to load core data stack: \(error)")
            }
            completion()
        }
    }
    
    
}
