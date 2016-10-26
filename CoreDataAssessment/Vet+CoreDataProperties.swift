//
//  Vet+CoreDataProperties.swift
//  CoreDataAssessment
//
//  Created by Flatiron School on 10/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Vet {

    @NSManaged var name: String?
    @NSManaged var hospitals: Set<Hospital>?
    @NSManaged var pets: Set<Pet>?

}
