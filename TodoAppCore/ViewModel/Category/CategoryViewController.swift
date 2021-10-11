//
//  CategoryViewController.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var categoryTitle  : UITextField!
    
    
    //MARK: - CLASS REFERENCES
    var dataViewModel = Injection.provide.CategoryViewModelInjection()
    var category: Category?
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categoryTitle.text = category?.categoryTitle
    }
    
    //MARK: - IBACTIONS
    @IBAction func submit(_ sender: Any) {
        if category != nil {
            dataViewModel.updateCategory(category: Category(id: (category?.id)!, categoryTitle: categoryTitle.text!)) { value in
                print(value)
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            //            print("Insert")
            if categoryTitle.text != ""{
                let categoryInstance = Category(id: UUID(), categoryTitle: categoryTitle.text!)
                dataViewModel.createCategory(category: categoryInstance) { result in
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                print("add title first")
            }
        }
        
    }
    
}
