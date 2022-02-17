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
        textColor = UIColor(hexString: "005CCC")
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        gradientBorder(width: 2.0, colors: [UIColor(hexString: "005CCC"), UIColor(hexString: "07E4E4")], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 1.0, y: 0.0))
        applyBackgroundGradient(colors:[UIColor(hexString: "005CCC").withAlphaComponent(0.1), UIColor(hexString: "07E4E4").withAlphaComponent(0.1)])
    }
}
