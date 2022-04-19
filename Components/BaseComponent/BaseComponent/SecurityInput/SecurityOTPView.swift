//
//  SecurityOTPView.swift
//  BaseComponent
//
//  Created by sky on 4/17/22.
//

import UIKit

public class SecurityOTPView: BaseView {
    
    var state: SecurityOTPState = .empty {
        didSet {
            underlineView.backgroundColor = state.getUnderlineColor()
            underlineHeightConstraint?.constant = state.getUnderlineHeight()
        }
    }
    
    var inputValue: String = "" {
        didSet {
            inputLabel.attributedText = NSAttributedString(string: inputValue, typesetting: Typesetting.smallTitle.centered.at(color: state.getInputColor()))
        }
    }
    
    var underlineHeightConstraint: NSLayoutConstraint?
    
    lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = state.getUnderlineColor()
        return view
    }()
    
    public override func setupView() {
        super.setupView()
        
        self.addSubview(inputLabel)
        self.addSubview(underlineView)
        
        NSLayoutConstraint.activate([
            inputLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            inputLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            inputLabel.heightAnchor.constraint(equalTo: self.widthAnchor),
            inputLabel.topAnchor.constraint(equalTo: self.topAnchor),
            inputLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Spacing.tiny),
            
            underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        underlineHeightConstraint = underlineView.heightAnchor.constraint(equalToConstant: 1)
        underlineHeightConstraint?.isActive = true
    }
}

public enum SecurityOTPState {
    case empty
    case filling
    case filled
    case error
    
    func getUnderlineColor() -> UIColor {
        switch self {
        case .empty, .filled:
            return BaseColor.Grey.grey_50
        case .filling:
            return BaseColor.Indigo.indigo_50
        case .error:
            return BaseColor.Denotive.red_50
        }
    }
    
    func getUnderlineHeight() -> CGFloat {
        switch self {
        case .empty, .filled:
            return 1
        default:
            return 2
        }
    }
    
    func getInputColor() -> UIColor {
        switch self {
        case .empty, .filling:
            return .clear
        case .filled:
            return BaseColor.Grey.grey_100
        case .error:
            return BaseColor.Denotive.red_50
        }
    }
    
}
