//
//  CDTodo+CoreDataProperties.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//
//

import Foundation
import CoreData


extension CDTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTodo> {
        return NSFetchRequest<CDTodo>(entityName: "CDTodo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var is_checked: Bool
    @NSManaged public var todo_title: String?
    @NSManaged public var todo_category: CDCategory?

}

extension CDTodo : Identifiable {

}
