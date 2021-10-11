//
//  TodoViewModel.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation

//MARK: -  TODO VIEW MODEL
class TodoViewModel{
    var repository: TodoRepository?
    
    init(repository: TodoRepository) {
        self.repository = repository
    }
    
    func createTodo(todo: Todo, completion: @escaping (Result<Todo>) -> ()) {
        repository?.createTodo(todo: todo, completion: { result in
            switch result{
            case .success(let todoInstance):
                completion(.success(todoInstance))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getAllTodos(completion: @escaping (Result<[Todo]>) -> ())  {
        repository?.getAllTodos(completion: { data in
            switch data{
            case .success(let todos):
                completion(.success(todos))
            case .failure(let err):
                print(err)
            }
        })
    }
    
    func getTodo(identifier id: UUID, completion: @escaping (Todo) -> ()){
        repository?.getTodo(identifier: id, completion: {todo in
            return completion(todo)
        })
    }
    
    func deleteTodo(todo: Todo, completion: @escaping (Bool) -> ()){
        repository?.deleteTodo(todo: todo, completion: { result in
            return completion(result)
        })
    }
    
    func updateTodo(todo: Todo, completion: @escaping (Bool) -> ()){
        repository?.updateTodo(todo: todo, completion: { result in
            return completion(result)
        })
    }
    
}
