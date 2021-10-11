//
//  CDCategory+CoreDataProperties.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//
//

import Foundation
import CoreData


extension CDCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategory> {
        return NSFetchRequest<CDCategory>(entityName: "CDCategory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var category_title: String?
    @NSManaged public var todos: NSSet?
    
    func returnCategoryObject() -> Category {
        return Category(id: self.id!, categoryTitle: self.category_title!)
    }

}

// MARK: Generated accessors for todos
extension CDCategory {

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: CDTodo)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: CDTodo)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSSet)

}

extension CDCategory : Identifiable {

}
