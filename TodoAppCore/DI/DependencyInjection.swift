//
//  DependencyInjection.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation

class Injection{
    static let provide = Injection()

    func CategoryViewModelInjection() -> CategoryViewModel{
        return CategoryViewModel(repository: CategoryDataRepository.shared)
    }
    
    func TodoViewModelInjection() -> TodoViewModel{
        return TodoViewModel(repository: TodoDataRepository.shared)
    }

}
