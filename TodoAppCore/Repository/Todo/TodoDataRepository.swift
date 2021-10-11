//
//  TodoDataRepository.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation
import CoreData

class TodoDataRepository: TodoRepository {
    private init(){}
    static let shared = TodoDataRepository()
    
    var persistent = PersistentStorage.shared
    
    func createTodo(todo: Todo, completion: @escaping (Result<Todo>) -> ()) {
        print(todo.todoCategory)
        let managedContext = persistent.context
        let cdTodo = CDTodo(context: managedContext)
        cdTodo.id = todo.id
        cdTodo.todo_title = todo.todoTitle
        cdTodo.is_checked = false
        cdTodo.todo_category = getCategoryUsingId(id: todo.todoCategory.id)
        
        do {
            try managedContext.save()
            completion(.success(todo))
          } catch let error as NSError {
            completion(.failure(error))
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    
    
    func updateTodo(todo: Todo, completion: @escaping (Bool) -> ()) {
        let todoInstance = getTodoUsingId(id: todo.id)
        guard todoInstance != nil else {
            return
        }
        todoInstance?.todo_title = todo.todoTitle
        todoInstance?.is_checked = todo.isChecked
        todoInstance?.todo_category?.id = todo.todoCategory.id
        persistent.saveContext()
        completion(true)
    }
    
    func deleteTodo(todo: Todo, completion: @escaping (Bool) -> ()) {
        let todoInstance = getTodoUsingId(id: todo.id)
        guard todoInstance != nil else {
            return
        }
        persistent.context.delete(todoInstance!)
        persistent.saveContext()
        completion(true)
    }
    
    func getTodo(identifier id: UUID, completion: @escaping (Todo) -> ()) {
        let todo = getTodoUsingId(id: id)
        guard todo != nil else {return}
//        return Category(id: (category?.id)!, title: (category?.title)!, image: (category?.image)!)
        return completion((todo?.returnTodoObject())!)
    }
    
    func getAllTodos(completion: @escaping (Result<[Todo]>) -> ()) {
        var todos: [Todo] = []
        let result = persistent.fetchManagedObject(managedObject: CDTodo.self)
        result?.forEach({ (cdTodo) in
            todos.append(cdTodo.returnTodoObject())
        })
        completion(.success(todos))
    }
    
    private func getTodoUsingId(id: UUID) -> CDTodo? {
        let fetchRequest = NSFetchRequest<CDTodo>(entityName: "CDTodo")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try persistent.context.fetch(fetchRequest).first
            guard result != nil else {
                return nil
            }
            return result
        } catch let error {
            print(error)
        }
        return nil
    }

    private func getCategoryUsingId(id: UUID) -> CDCategory? {
        let fetchRequest = NSFetchRequest<CDCategory>(entityName: "CDCategory")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try persistent.context.fetch(fetchRequest).first
            guard result != nil else {
                return nil
            }
            return result
        } catch let error {
            print(error)
        }
        return nil
    }
}
