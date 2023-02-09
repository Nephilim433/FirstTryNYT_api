//
//  Link+CoreDataProperties.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/9/23.
//
//

import Foundation
import CoreData


extension Link {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Link> {
        return NSFetchRequest<Link>(entityName: "Link")
    }

    @NSManaged public var link: String?
    @NSManaged public var name: String?
    @NSManaged public var book: Book?

}

extension Link : Identifiable {

}
