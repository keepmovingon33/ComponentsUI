//
//  SecurityView.swift
//  BaseComponent
//
//  Created by sky on 4/14/22.
//

import UIKit

public class SecurityView: BaseView {
    var securityState: SecurityState = .empty {
        didSet {
            // moi lan state thay doi, thi no se run lai didSet. No co the run nhieu lan, khac voi line 21
            mainView.backgroundColor = securityState.mainColor
        }
    }
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // khi moi vo, no se set mau cho cai mainView lan dau tien. Va line nay chi run duy nhat 1 lan
        view.backgroundColor = securityState.mainColor
        return view
    }()
    
    public override func setupView() {
        super.setupView()
        self.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.heightAnchor.constraint(equalToConstant: Spacing.medium),
            mainView.widthAnchor.constraint(equalToConstant: Spacing.medium),
        ])
        
        mainView.cornerRadius = Spacing.small
    }
    
}

public enum SecurityState {
    case empty
    case filled
    case error
    
    var mainColor: UIColor {
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
