//
//  PracticeInputPinView.swift
//  BaseComponent
//
//  Created by sky on 4/24/22.
//

import UIKit

public class PracticeInputPinView: BaseView {
    var state: PracticePinViewState = .empty {
        didSet {
            pinView.backgroundColor = state.getViewColor()
        }
    }
    lazy var pinView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = state.getViewColor()
        return view
    }()
    
    public override func setupView() {
        self.addSubview(pinView)
        NSLayoutConstraint.activate([
            pinView.topAnchor.constraint(equalTo: self.topAnchor),
            pinView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pinView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pinView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pinView.heightAnchor.constraint(equalToConstant: Spacing.medium),
            pinView.widthAnchor.constraint(equalToConstant: Spacing.medium)
        ])
        
        pinView.cornerRadius = Spacing.small
    }
}

enum PracticePinViewState {
    case empty
    case filled
    case error
    
    func getViewColor() -> UIColor {
        switch self {
        case .empty:
            return BaseColor.Indigo.indigo_10
        case .filled:
            return BaseColor.Indigo.indigo_50
        case .error:
            return BaseColor.Denotive.red_50
        }
    }
}
