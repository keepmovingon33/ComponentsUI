//
//  BaseDropDown.swift
//  BaseComponent
//
//  Created by sky on 4/1/22.
//

import UIKit

public class BaseDropDown: BaseInput {
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var toolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneAction(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelAction(_:)))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        return toolbar
    }()
    
    @objc func doneAction(_ input: UIBarButtonItem) {
        let item = pickerView.selectedRow(inComponent: 0) // we only have one section
        textField.text = data[item]
        textField.endEditing(true)
    }
    
    @objc func cancelAction(_ input: UIBarButtonItem) {
        textField.endEditing(true)
    }
    
    var data = ["1","2","3","4","5","6","7","8","9"]
    
    override func setupMiddleView() {
        rightButton.setImage(ImageProvider.image(named: "ic_chevron_down"), for: .normal)
        textField.inputView = pickerView
//        textField.inputAccessoryView = toolbar
    }
    
    override func rightButtonTapped(_ input: UIButton) {
        
    }
    
    override func updateInputField() {
        textField.textColor = inputState.getInputColor()
        rightButton.tintColor = inputState.getClearButtonColor()
    }
    
    override func textFieldDidChange(_ textField: UITextField) {
        
    }
}

extension BaseDropDown: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}
