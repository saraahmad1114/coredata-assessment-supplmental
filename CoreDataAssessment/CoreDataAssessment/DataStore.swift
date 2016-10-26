//
//  DataStore.swift
//  CoreDataAssessment
//
//  Created by Flatiron School on 10/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    var hospitals: [Hospital] = []
    var vets: [Vet] = []
    var pets: [Pet] = []
    
    static let sharedInstance = DataStore()
    private init() {}
    

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.first.CoreDataAssessment" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("CoreDataAssessment", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    

    func fetchData() {
    
        var error: NSError? = nil
        
        let hospitalRequest = NSFetchRequest(entityName: "Hospital")
        let vetRequest = NSFetchRequest(entityName: "Vet")
        let petRequest = NSFetchRequest(entityName: "Pet")
        
        let hospitalNameSorted = NSSortDescriptor(key: "name", ascending: true)
            hospitalRequest.sortDescriptors = [hospitalNameSorted]
        
        do {
            hospitals = try managedObjectContext.executeFetchRequest(hospitalRequest) as! [Hospital]
            vets = try managedObjectContext.executeFetchRequest(vetRequest) as! [Vet]
            pets = try managedObjectContext.executeFetchRequest(petRequest) as! [Pet]
        }
        catch let NSError as NSError{
            error = NSError
            print("error \(error)")
            hospitals = []
            vets = []
            pets = []
        }
        
        if hospitals.count == 0{
            if vets.count == 0 || pets.count == 0{
            self.generateTestData()
            }
        }
    }
    
    func generateTestData(){
        
        let hospitalOne: Hospital = NSEntityDescription.insertNewObjectForEntityForName("Hospital", inManagedObjectContext: managedObjectContext) as! Hospital
        hospitalOne.name = "Hospital One"
        
        let vetOne: Vet = NSEntityDescription.insertNewObjectForEntityForName("Vet", inManagedObjectContext: managedObjectContext) as! Vet
        vetOne.name = "Vet One"
        
        hospitalOne.vets?.insert(vetOne)
        vetOne.hospitals?.insert(hospitalOne)
        
        let petOne: Pet = NSEntityDescription.insertNewObjectForEntityForName("Pet", inManagedObjectContext: managedObjectContext) as! Pet
        petOne.name = "Pet One"
        vetOne.pets?.insert(petOne)
        
        petOne.hospital = hospitalOne
        petOne.vet = vetOne
        
        //********************************************************************************
        
        let hospitalTwo: Hospital = NSEntityDescription.insertNewObjectForEntityForName("Hospital", inManagedObjectContext: managedObjectContext) as! Hospital
        hospitalTwo.name = "Hospital Two"
        
        let vetTwo: Vet = NSEntityDescription.insertNewObjectForEntityForName("Vet", inManagedObjectContext: managedObjectContext) as! Vet
        vetTwo.name = "Vet Two"
        
        hospitalTwo.vets?.insert(vetTwo)
        vetTwo.hospitals?.insert(hospitalTwo)
        
        let petTwo: Pet = NSEntityDescription.insertNewObjectForEntityForName("Pet", inManagedObjectContext: managedObjectContext) as! Pet
        petTwo.name = "Pet Two"
        petTwo.hospital = hospitalTwo
        
        vetTwo.pets?.insert(petTwo)
        petTwo.vet = vetTwo
        
        //********************************************************************************
        
        let hospitalThree: Hospital = NSEntityDescription.insertNewObjectForEntityForName("Hospital", inManagedObjectContext: managedObjectContext) as! Hospital
        hospitalThree.name = "Hospital Three"
        
        let vetThree: Vet = NSEntityDescription.insertNewObjectForEntityForName("Vet", inManagedObjectContext: managedObjectContext) as! Vet
        vetThree.name = "Vet Three"
        
        hospitalThree.vets?.insert(vetThree)
        vetThree.hospitals?.insert(hospitalThree)
        
        let petThree: Pet = NSEntityDescription.insertNewObjectForEntityForName("Pet", inManagedObjectContext: managedObjectContext) as! Pet
        petThree.name = "Pet Three"
        
        vetThree.pets?.insert(petThree)
        
        petThree.vet = vetThree
        petThree.hospital = hospitalThree
        
        //********************************************************************************

        
        let hospitalFour: Hospital = NSEntityDescription.insertNewObjectForEntityForName("Hospital", inManagedObjectContext: managedObjectContext) as! Hospital
        hospitalFour.name = "Hospital Four"
        
        let vetFour: Vet = NSEntityDescription.insertNewObjectForEntityForName("Vet", inManagedObjectContext: managedObjectContext) as! Vet
        vetFour.name = "Vet Four"
        
        hospitalFour.vets?.insert(vetFour)
        vetFour.hospitals?.insert(hospitalFour)
        
        let petFour: Pet = NSEntityDescription.insertNewObjectForEntityForName("Pet", inManagedObjectContext: managedObjectContext) as! Pet
        petFour.name = "Pet Four"
        vetFour.pets?.insert(petFour)
        
        petFour.vet = vetFour
        petFour.hospital = hospitalFour
        
        fetchData()
        saveContext()
        
    }

}