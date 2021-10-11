//
//  CategoryRespository.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation


protocol CategoryRepository {
    func createCategory(category: Category, completion: @escaping (Result<Category>) -> ())
    func updateCategory(category: Category, completion: @escaping (Bool) -> ())
    func deleteCategory(category: Category, completion: @escaping (Bool) -> ())
    func getCategory(identifier id: UUID,  completion: @escaping (Category) -> ())
    func getAllCategories(completion: @escaping (Result<[Category]>) -> ())
}
