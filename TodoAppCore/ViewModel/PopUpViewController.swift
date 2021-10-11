//
//  PopUpViewController.swift
//  TodoAppCore
//
//  Created by Naveed Tahir on 06/10/2021.
//

import Foundation
import UIKit


class PopUpViewController: UIViewController {
    //MARK: - IBOUTLETS
    @IBOutlet weak var popTitle         : UILabel!
    @IBOutlet weak var categoryPicker   : UIPickerView!
    @IBOutlet weak var todoTitle        : UITextField!
    @IBOutlet weak var submitBtnOutlet  : UIButton!
    @IBOutlet weak var popUpView        : UIView!
    
    //MARK: - Properties
    var popupTitle: String?
    var saveBtnText: String?
    var textFieldPlaceHolder: String?
    var actiontype: ActionType = .add
    var textFieldValue: String?
    
    var dataSource: [String] = []
    var pickerIndex: Int = 0
    var selectedCategoryFromPicker: String?
    
    //MARK: - CALLBACKS
    var onSubmitBlock : ((String,Int) -> ())?
    var onCancelBlock :  (() -> ())?

    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    //MARK: - IBACTIONS
    @IBAction func submitAction(_ sender: Any) {
        if todoTitle.text != ""{
            if let onSubmitBlock = onSubmitBlock{
                onSubmitBlock(todoTitle.text!,pickerIndex)
            }
        }
        else{
            print("add something")
        }
    }
    
    @IBAction func dimissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        if let onCancelBlock = onCancelBlock{
            onCancelBlock()
        }
    }
    
    //MARK: - FUNCTIONS
    func setupViews() {
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        popTitle.text = popupTitle
        todoTitle.placeholder = textFieldPlaceHolder
        todoTitle.text = textFieldValue
        submitBtnOutlet.setTitle(saveBtnText, for: .normal)
        popUpView.layer.cornerRadius = 20
        self.hideKeyboardWhenTappedAround()
        if actiontype == .update{
            categoryPicker.selectRow(pickerIndex, inComponent: 0, animated: true)
        }
        
    }
    
    func setAlertProps(dataSource: [String], title: String, btnTitle: String, placeHolder: String , actionType: ActionType, onSubmitBlock: ((String,Int) -> Void)?, onCancelBlock : (() -> ())?){
        self.dataSource = dataSource
        self.popupTitle = title
        self.saveBtnText = btnTitle
        self.textFieldPlaceHolder  = placeHolder
        self.actiontype = actionType
        self.onSubmitBlock = onSubmitBlock
        self.onCancelBlock = onCancelBlock
    }
    
    func setAlertProps(dataSource: [String], title: String, saveBtnTitle: String, placeHolder: String , textfieldValue: String,actionType: ActionType, pickerIndex: Int, onSubmitBlock: ((String,Int) -> Void)?, onCancelBlock : (() -> ())?){
        self.dataSource = dataSource
        self.popupTitle = title
        self.saveBtnText = saveBtnTitle
        self.textFieldValue = textfieldValue
        self.pickerIndex = pickerIndex
        self.textFieldPlaceHolder  = placeHolder
        self.actiontype = actionType
        self.onSubmitBlock = onSubmitBlock
        self.onCancelBlock = onCancelBlock
    }
}


//MARK: - UIPCIKERVIEW DELEAGATES
extension PopUpViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataSource[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategoryFromPicker = dataSource[row]
        pickerIndex = row
    }
    
}
