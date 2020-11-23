//
//  Product+CoreDataProperties.swift
//  Inventroy System
//
//  Created by Ahmed Nasr on 11/23/20.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productID: Int64
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Int64
    @NSManaged public var productQuantity: Int64
    @NSManaged public var productImage: Data?

}

extension Product : Identifiable {

}
