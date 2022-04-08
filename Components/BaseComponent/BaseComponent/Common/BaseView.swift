//
//  BaseView.swift
//  BaseComponent
//
//  Created by sky on 4/8/22.
//

import UIKit

public class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func setupView() {}
}

