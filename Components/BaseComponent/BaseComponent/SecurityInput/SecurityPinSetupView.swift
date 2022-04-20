//
//  SecurityPinSetupView.swift
//  BaseComponent
//
//  Created by sky on 4/19/22.
//

import UIKit

public class SecurityPinSetupView: SecurityOTPView {
    
    lazy var roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = 8
        return view
    }()
    
    override func stateChanged() {
        underlineView.backgroundColor = state.getUnderlineViewColorForPinSetup()
        inputLabel.attributedText = NSAttributedString(string: inputValue, typesetting: Typesetting.mediumTitle.centered.at(color: state.getInputColor()))
        if state == .filled {
            UIView.animate(withDuration: 0.3, delay: 0.2) { [weak self] in
                self?.roundedView.backgroundColor = self?.state.getRoundedViewColor()
            }
        } else {
            roundedView.backgroundColor = state.getRoundedViewColor()
        }
    }
    
    public override func setupView() {
        self.addSubview(inputLabel)
        self.addSubview(underlineView)
        self.addSubview(roundedView)
        
        NSLayoutConstraint.activate([
            inputLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            inputLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            inputLabel.topAnchor.constraint(equalTo: self.topAnchor),
            inputLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            inputLabel.heightAnchor.constraint(equalToConstant: Spacing.huge),
            inputLabel.widthAnchor.constraint(equalToConstant: Spacing.extraLarge),
            
            underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underlineView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            
            roundedView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            roundedView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            roundedView.widthAnchor.constraint(equalToConstant: Spacing.medium),
            roundedView.heightAnchor.constraint(equalToConstant: Spacing.medium)
        ])
    }
}

extension SecurityOTPState {
    func getRoundedViewColor() -> UIColor {
        switch self {
        case .empty, .filling:
            return .clear
        case .filled:
            return BaseColor.Indigo.indigo_50
        case .error:
            return BaseColor.Denotive.red_50
        }
    }
    
    func getUnderlineViewColorForPinSetup() -> UIColor {
        switch self {
        case .empty:
            return BaseColor.Grey.grey_100
        case .filling:
            return BaseColor.Indigo.indigo_50
        case .filled, .error:
            return .clear
        }
    }
}
