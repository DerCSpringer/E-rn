//
//  Agreement+CoreDataProperties.swift
//  E:rn
//
//  Created by Daniel on 10/15/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import Foundation
import CoreData


extension Agreement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Agreement> {
        return NSFetchRequest<Agreement>(entityName: "Agreement");
    }

    @NSManaged public var child: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var forItem: String?
    @NSManaged public var name: String?
    @NSManaged public var parent: String?
    @NSManaged public var terms: String?
    @NSManaged public var value: String?
    @NSManaged public var withPerson: String?

}
