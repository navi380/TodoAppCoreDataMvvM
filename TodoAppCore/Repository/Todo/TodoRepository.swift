//
//  TodoRepository.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation

protocol TodoRepository {
    func createTodo(todo: Todo, completion: @escaping (Result<Todo>) -> ())
    func updateTodo(todo: Todo, completion: @escaping (Bool) -> ())
    func deleteTodo(todo: Todo, completion: @escaping (Bool) -> ())
    func getTodo(identifier id: UUID, completion: @escaping (Todo) -> ())
    func getAllTodos(completion: @escaping (Result<[Todo]>) -> ())
}

