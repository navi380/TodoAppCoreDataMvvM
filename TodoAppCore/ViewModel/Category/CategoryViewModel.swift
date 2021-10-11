//
//  CategoryViewModel.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//


import Foundation


class CategoryViewModel{
    var repository: CategoryRepository?
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func createCategory(category: Category, completion: @escaping (Category) -> ()){
        repository?.createCategory(category: category, completion: { result in
            switch result{
            case .success(let categoryInstance):
                completion(categoryInstance)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getAllCategories(completion: @escaping ([Category]) -> ())  {
        repository?.getAllCategories(completion: { data in
            switch data{
            case .success(let category_data):
                completion(category_data)
            case .failure(let err):
                print(err)
            }
        })
    }
    
    func deleteCategory(category: Category, completion: @escaping (Bool) -> ()){
        repository?.deleteCategory(category: category, completion: { value in
            completion(value)
        })
    }
    
    func updateCategory(category: Category, completion: @escaping (Bool) -> ()){
        repository?.updateCategory(category: category, completion: { value in
            completion(value)
        })
    }
    

}
