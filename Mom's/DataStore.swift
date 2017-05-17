//
//  DataStore.swift
//  Mom's
//
//  Created by Armond St.Juste on 5/13/17.
//  Copyright © 2017 Me. All rights reserved.
//

import Foundation
import CoreData
import EventKit
import UIKit

class DataStore: NSManagedObject{
    
    @NSManaged var eventStore:EKEventStore
    
    @NSManaged var eventIdentifiers: [String:String]
    
    @NSManaged var calendar:EKCalendar
    
    @NSManaged var hasBeenSetup:Bool
    
    
    
}
