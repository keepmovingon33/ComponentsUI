//
//  ButtonComponent.swift
//  Components
//
//  Created by sky on 2/16/22.
//

import UIKit

open class PrimaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = ColorComponent.primary
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = UIColor(white: 1, alpha: 0.5)
        rippleBackgroundColor = ColorComponent.primary
        textColor = .black
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
}

open class SecondaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = .white
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = UIColor(hexString: "E7EAF3")
        rippleBackgroundColor = .white
        textColor = .black
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        borderColor = .black
        borderWidth = 1
    }
}

open class SmallPrimaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = .black
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = UIColor(white: 1, alpha: 0.5)
        rippleBackgroundColor = .black
        textColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    }
}


open class SmallSecondaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = .white
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = UIColor(hexString: "F2F4F7")
        rippleBackgroundColor = .white
        textColor = .black
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        borderColor = UIColor(hexString: "D6DBEB")
        borderWidth = 1
    }
}

open class ChipButton: RippleButton {
    public override func setup() {
        backgroundColor = .white
        cornerRadius = frame.height / 2
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        backgroundColor = UIColor(hexString: "F5F5F5")
        borderColor = UIColor(hexString: "E7EAF3")
        borderWidth = 1
        textColor = .black
        setTitleColor(UIColor(hexString: "005CCC"), for: .selected)
        tintColor = .clear
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }
    
    @objc func didButtonTapped(_ sender: UIButton) {
        isSelected = !isSelected
    }
    
    open override var isSelected: Bool {
        didSet {
            if isSelected {
                gradientBorder(width: 2.0, colors: [UIColor(hexString: "005CCC"), UIColor(hexString: "07E4E4")], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 1.0, y: 0.0))
                applyBackgroundGradient(colors:[UIColor(hexString: "005CCC").withAlphaComponent(0.1), UIColor(hexString: "07E4E4").withAlphaComponent(0.1)])
            } else {
                removeBorderLayer()
                removeBackgroundLayer()
            }
        }
    }
    
}

open class ActionButton: ChipButton {
    public override func setup() {
        super.setup()
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        contentHorizontalAlignment = .right
        if let image = UIImage(named: "ic_right") {
            setImage(image, for: .normal)
        }
        if #available(iOS 15.0, *) {
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
            configuration?.imagePlacement = .trailing
            
            configuration?.titlePadding = 50
        } else {
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            
        }
        
        
    }
}
