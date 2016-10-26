//
//  Hospital+CoreDataProperties.swift
//  CoreDataAssessment
//
//  Created by Flatiron School on 10/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Hospital {

    @NSManaged var name: String?
    @NSManaged var vets: Set<Vet>?
    //@NSManaged var newRelationship: Pet?

}
