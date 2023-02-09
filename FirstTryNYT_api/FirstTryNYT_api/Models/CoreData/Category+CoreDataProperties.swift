//
//  Category+CoreDataProperties.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/9/23.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var listNameEncoded: String?
    @NSManaged public var name: String?
    @NSManaged public var newestPublishedDate: String?
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension Category {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension Category : Identifiable {

}
