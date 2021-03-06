//
//  Results.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case failure(Error)
}
