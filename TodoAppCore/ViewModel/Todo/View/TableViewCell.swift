//
//  TableViewCell.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import UIKit

//MARK: -  TODO TABLE VIEW CELL
class TableViewCell: UITableViewCell{
    //MARK: -  IBOUTLETS
    @IBOutlet weak var todoTitle: UILabel!
    
    @IBOutlet weak var isChecked: UIButton!
    
    //MARK: -  LIFE CYCLE
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
    //MARK: -  IBACTIONS
    @IBAction func btnChecked(_ sender: Any) {
    }
    
    
    //MARK: -  OTHER FUNCTIONS
    func config(todo: Todo){
               self.todoTitle.text = todo.todoTitle
               self.isChecked.isSelected = todo.isChecked
           }
    
}
