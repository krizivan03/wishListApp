//
//  itemModel.swift
//  wishListApp
//
//  Created by Christopher Canales on 3/21/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import Foundation
import CoreData

public class itemModel {
    let managedObjectContext:NSManagedObjectContext
    
    init(context: NSManagedObjectContext)
    {
        managedObjectContext = context
        
        // Getting a handler to the coredata managed object context
    }
    /*------------------------------------------------------------*/
    func fetchRecord() -> [Item] {
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let sort = NSSortDescriptor(key: "itemName", ascending: true)
        
        fetchRequest.sortDescriptors = [sort]
        
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        let fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [Item])!
        
        return fetchResults
    }
    
}
