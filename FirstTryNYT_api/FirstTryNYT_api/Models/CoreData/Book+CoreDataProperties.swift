//
//  Book+CoreDataProperties.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/9/23.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var bookName: String?
    @NSManaged public var booksDescription: String?
    @NSManaged public var image: Data?
    @NSManaged public var publisher: String?
    @NSManaged public var rank: Int16
    @NSManaged public var category: Category?
    @NSManaged public var link: NSSet?

}

// MARK: Generated accessors for link
extension Book {

    @objc(addLinkObject:)
    @NSManaged public func addToLink(_ value: Link)

    @objc(removeLinkObject:)
    @NSManaged public func removeFromLink(_ value: Link)

    @objc(addLink:)
    @NSManaged public func addToLink(_ values: NSSet)

    @objc(removeLink:)
    @NSManaged public func removeFromLink(_ values: NSSet)

}

extension Book : Identifiable {

}
