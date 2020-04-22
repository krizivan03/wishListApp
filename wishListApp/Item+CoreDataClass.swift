//
//  Item+CoreDataClass.swift
//  wishListApp
//
//  Created by Christopher Canales on 4/17/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemLocation: String?
    @NSManaged public var itemName: String?
    @NSManaged public var itemPrice: Double
    @NSManaged public var itemURL: String?
    @NSManaged public var itemImage: Data?

}
