//
//  CategoryDataRepository.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation
import CoreData

class CategoryDataRepository: CategoryRepository {

    private init(){}
    static let shared = CategoryDataRepository()
    
    var persistent = PersistentStorage.shared
    
    func createCategory(category: Category , completion: @escaping (Result<Category>)-> ()) {
        let managedContext = persistent.context
        let cdCategory = CDCategory(context: managedContext)
        cdCategory.id = category.id
        cdCategory.category_title = category.categoryTitle
        do {
            try managedContext.save()
            completion(.success(category))
          } catch let error as NSError {
            completion(.failure(error))
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    
    func updateCategory(category: Category, completion: @escaping (Bool) -> ()) {
        let categoryInstance = getCategoryUsingId(id: category.id)
        guard categoryInstance != nil else {
            return
        }
        categoryInstance?.category_title = category.categoryTitle
        persistent.saveContext()
        return completion(true)
    }
    
    func deleteCategory(category: Category, completion: @escaping (Bool) -> ()) {
        let categoryInstance = getCategoryUsingId(id: category.id)
        guard categoryInstance != nil else {
            return
        }
        persistent.context.delete(categoryInstance!)
        persistent.saveContext()
        completion(true)
    }
    
    func getCategory(identifier id: UUID, completion: @escaping (Category) -> ()) {
        let category = getCategoryUsingId(id: id)
        guard category != nil else {return}
//        return Category(id: (category?.id)!, title: (category?.title)!, image: (category?.image)!)
        return completion((category?.returnCategoryObject())!)
    }
    
    func getAllCategories(completion: @escaping (Result<[Category]>) -> ()) {
        var categories: [Category] = []
        let result = persistent.fetchManagedObject(managedObject: CDCategory.self)
        result?.forEach({ (cdCategory) in
            categories.append(cdCategory.returnCategoryObject())
        })
        completion(.success(categories))
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
