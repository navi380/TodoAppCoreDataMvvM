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
    
    func returnTodoCategory() -> Category{
        return Category(id: (self.todo_category?.id)!, categoryTitle: (self.todo_category?.category_title)!)
    }
    
    func returnTodoObject() -> Todo {
        return Todo(id: self.id!, todoTitle: self.todo_title!, isChecked: self.is_checked, todoCategory: returnTodoCategory())
    }

}

extension CDTodo : Identifiable {

}
