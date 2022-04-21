//
//  BaseNumpadKeyboardView.swift
//  BaseComponent
//
//  Created by sky on 4/20/22.
//

import UIKit

public class BaseNumpadKeyboardView: BaseView {
    lazy var numpadStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Spacing.huge
        return stackView
    }()
    
    public override func setupView() {
        self.addSubview(numpadStackView)
        
        
        
        NSLayoutConstraint.activate([
            numpadStackView.topAnchor.constraint(equalTo: self.topAnchor),
            numpadStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            numpadStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numpadStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            numpadStackView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        setupStackview()
    }
    
    func setupStackview() {
//        let view1 = NumpadKeyboardCellItem()
//        view1.numpadType = .numpad
//        numpadStackView.addArrangedSubview(view1)
//        
//        let view4 = NumpadKeyboardCellItem()
//        view4.numpadType = .delete
//        numpadStackView.addArrangedSubview(view4)
//        
//        let view2 = NumpadKeyboardCellItem()
//        view2.numpadType = .numpad
//        numpadStackView.addArrangedSubview(view2)
//        
//        let view3 = NumpadKeyboardCellItem()
//        view3.numpadType = .delete
//        numpadStackView.addArrangedSubview(view3)
//        
        
    }
}
