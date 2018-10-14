//
//  Person+CoreDataProperties.swift
//  HitListCoreData
//
//  Created by shelly.gupta on 7/1/18.
//  Copyright © 2018 shelly.gupta. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?

}
