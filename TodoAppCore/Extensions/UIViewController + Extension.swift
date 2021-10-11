//
//  UIViewController + Extension.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showPopup(dataSource: [String], title: String, saveBtnTitle: String, placeHolder: String , actionType: ActionType, onSubmitBlock: ((String,Int) -> Void)?, onCancelBlock : (() -> ())?){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        vc.setAlertProps(dataSource: dataSource, title: title, btnTitle: saveBtnTitle, placeHolder: placeHolder, actionType: actionType, onSubmitBlock: onSubmitBlock, onCancelBlock: onCancelBlock)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func showPopup(dataSource: [String], title: String, saveBtnTitle: String, placeHolder: String , textfieldValue: String,actionType: ActionType, pickerIndex: Int, onSubmitBlock: ((String,Int) -> Void)?, onCancelBlock : (() -> ())?){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        vc.setAlertProps(dataSource: dataSource, title: title, saveBtnTitle: saveBtnTitle, placeHolder: placeHolder, textfieldValue: textfieldValue, actionType: actionType, pickerIndex: pickerIndex, onSubmitBlock: onSubmitBlock, onCancelBlock: onCancelBlock)
        self.present(vc, animated: true, completion: nil)
    }
}
