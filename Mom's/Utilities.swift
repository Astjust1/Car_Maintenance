//
//  Utilities.swift
//  Mom's
//
//  Created by Armond St.Juste on 5/11/17.
//  Copyright © 2017 Me. All rights reserved.
//

import Foundation
import EventKit
import UIKit

class Utils {
    /**
     
     The completion stuff is relatively confusing, but it seems to be an implicit way to send different responses based on different outcomes
     
     Kinda like an implicit anonymous callback in javascript
 
 
 **/
    
    //Properties
    //static var eventDataToBeStored = DataStore(context: DataController.managedContext )
    static var eventStore = EKEventStore()
    
    static var eventIdentifiers: [String : String] = [:]
    
    static var calendar:EKCalendar?
    
    //static var authStatus:Bool?
    
    static var hasBeenSetup = false
    
    static func setup(){
        //Need Event store
        if eventStore == nil{
            eventStore = EKEventStore()
            //DispatchQueue.main.sync{
            
            //}
        }
        //Setup Calendar
        if calendar == nil{
            
                
                let calendars = eventStore.calendars(for: EKEntityType.event)
                
                let calendarTitle = "CARS"
                let filtered = calendars.filter{$0.title == calendarTitle}
                
                if filtered.count > 0{
                    calendar = filtered.first
                }else{
                    calendar = EKCalendar(for: EKEntityType.event, eventStore: eventStore)
                    calendar?.title = calendarTitle
                    calendar?.source = (eventStore.defaultCalendarForNewEvents.source)
                    
                    do{
                        try eventStore.saveCalendar(calendar!, commit: true)
                    }catch let e as NSError{
                        print(e)
                        return
                    }
                }
                
            
            buildIdentifierMap()
            hasBeenSetup = true
            print(hasBeenSetup)
           // print(calendar!)
           // print(eventStore)
            
        }
    }
    
    
   /** static func updatePermissions(controller:UIViewController){
        
        var status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch(status){
            case EKAuthorizationStatus.denied: break
            
            case EKAuthorizationStatus.restricted:
                authStatus = false
                var alert = UIAlertController(title: "Acess Denied", message: "This app does not have permission to do this", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                alert.show(controller, sender: self)
            
            case EKAuthorizationStatus.authorized:
                authStatus = true
                //controller.tableView.reloadData()
                break
            
            case EKAuthorizationStatus.notDetermined:
                var yep = self
                eventStore?.requestAccess(to: EKEntityType.event, completion:{(granted: Bool, error: NSError) in
                    DispatchQueue.main.async{
                        yep.authStatus = granted
                        
                        //controller.tableView.reloadData()
                    }
                } as! EKEventStoreRequestAccessCompletionHandler)
                break
        }
    } **/
    
    //This function is a monster
    
    static func addEventToCalendar(title: String, description: String?, monthsToExtend: Int, date: NSDate, completion:((_ success:Bool, _ error: NSError?) ->Void)? = nil){
        
        
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if(granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore);
                    
                    event.title = title
                    let newDate = Calendar.current.date(byAdding: .month, value: monthsToExtend, to: date as Date);
                    event.startDate = newDate!;
                    event.endDate = newDate!;
                    event.notes = description;
                    event.calendar = calendar!
                    
                    //check to see if event exists
                    if (eventIdentifiers.count > 0) && (eventIdentifiers[event.title] != nil){
                        
                        let prevEvent = eventStore.event(withIdentifier: eventIdentifiers[event.title]!)
                        if prevEvent == nil{
                            do {
                                try eventStore.save(event, span: .thisEvent)
                            } catch let e as NSError {
                                completion?(false, e)
                                print(e)
                                return
                            }
                            // Store event and identifier
                            eventIdentifiers[event.title] = event.eventIdentifier;
                            completion?(true,nil)
                            // print("success! ");
                            // print(event)
                        }else{
                            do {
                                
                                try eventStore.remove(prevEvent!, span: .thisEvent)
                                try eventStore.save(event, span: .thisEvent)
                            } catch let e as NSError{
                                completion?(false, e)
                                print(e)
                                return
                            }
                            eventIdentifiers[event.title] = event.eventIdentifier;
                            completion?(true,nil)
                            //print("success! ");
                            // print(event)
                            
                        }
                    }else{
                        do {
                            try eventStore.save(event, span: .thisEvent)
                        }catch let e as NSError{
                            completion?(false, e)
                            print(e)
                            return
                        }
                        completion?(true,nil)
                        eventIdentifiers[event.title] = event.eventIdentifier
                        print(eventIdentifiers)
                    }
                }else{
                    completion?(false, error as NSError?)
                    print(error!)
                }
                
                
            })
        
    }
    /**
        Test function to see if I can list all events in the store
        Also may come in handy if I decide to build a list of events after setup
 
    **/
    static func eventsInStore() -> [EKEvent]?{
        
        let today = Date()
        let cal = Calendar.current
        
        let year = cal.component(.year, from: today)
        let start = NSDateComponents();
        start.day = 1
        start.month = 1
        start.year = year
        
        let startDate = cal.date(from: start as DateComponents)
        
        let end = NSDateComponents()
        end.day = 31
        end.month = 12
        end.year = year
        
        let endDate = cal.date(from: end as DateComponents)
        
        if calendar != nil{
            let predicate = eventStore.predicateForEvents(withStart: startDate!, end: endDate!, calendars: [calendar!])
            let events = eventStore.events(matching: predicate)
            
            //print(events)
            
            return events
            
        }else{
            return nil
        }
    }
    
    static func buildIdentifierMap(){
        if let events = eventsInStore(){
        
                for e in events {
                    eventIdentifiers[e.title] = e.eventIdentifier
                }
            
        }
    }
    
    static func buildEventArray() -> [EKEvent]{
        if eventIdentifiers.count == 0 {
            buildIdentifierMap()
        }
        var keyArray = [EKEvent]()
       print("Building array")
        //print(eventIdentifiers)
        for (key,value) in Utils.eventIdentifiers{
            print(key)
            let event = eventStore.event(withIdentifier: value)
            keyArray.append(event!)
        }
        //print(keyArray)
        return keyArray
    }
    
    class func requestPermissions(eventStore: EKEventStore, controller: UIViewController){
        switch EKEventStore.authorizationStatus(for: EKEntityType.event){
        case .authorized:
            print("authorized")
        case .denied:
            print("Access denied")
        case .notDetermined:
                eventStore.requestAccess(to: .event, completion:
                    {[weak controller] (granted: Bool, error: Error?) -> Void in
                        
                        if granted {
                            print("Access Granted")
                        }else{
                            print("Access Denied")
                        }
                        
                })
        default:
            print("Case Default")
        }
    }
}
