//
//  TodoModel.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation


struct Todo {
    let id: UUID
    let todoTitle: String
    let isChecked: Bool
    var todoCategory: Category
}
