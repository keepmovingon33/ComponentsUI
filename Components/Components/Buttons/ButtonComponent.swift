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
        backgroundColor = ColorComponent.main
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = UIColor(white: 1, alpha: 0.5)
        rippleBackgroundColor = ColorComponent.main
        textColor = ColorComponent.Grey.grey_100
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
}

open class SecondaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = ColorComponent.Grey.grey_0
        cornerRadius = frame.height / 2
        // color for ripple
        
        rippleColor = ColorComponent.Indigo.indigo_10
        rippleBackgroundColor = ColorComponent.Grey.grey_0
        textColor = ColorComponent.Grey.grey_100
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        borderColor = ColorComponent.Grey.grey_100
        borderWidth = 1
    }
}

open class SmallPrimaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = ColorComponent.Grey.grey_100
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = UIColor(white: 1, alpha: 0.5)
        rippleBackgroundColor = ColorComponent.Grey.grey_100
        textColor = ColorComponent.Grey.grey_0
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    }
}


open class SmallSecondaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = ColorComponent.Grey.grey_0
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = ColorComponent.Indigo.indigo_5
        rippleBackgroundColor = ColorComponent.Grey.grey_0
        textColor = ColorComponent.Grey.grey_100
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        borderColor = ColorComponent.Indigo.indigo_20
        borderWidth = 1
    }
}

open class ChipButton: RippleButton {
    public override func setup() {
        if #available(iOS 15.0, *) {
            configuration = .none
        }
        backgroundColor = ColorComponent.Grey.grey_0
        cornerRadius = frame.height / 2
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        backgroundColor = ColorComponent.Grey.grey_5
        borderColor = ColorComponent.Indigo.indigo_10
        borderWidth = 1
        textColor = ColorComponent.Grey.grey_100
        setTitleColor(ColorComponent.Gradient.start, for: .selected)
        tintColor = .clear
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }
    
    @objc func didButtonTapped(_ sender: UIButton) {
        isSelected = !isSelected
    }
    
    open override var isSelected: Bool {
        didSet {
            if isSelected {
                gradientBorder(width: 2.0, colors: [ColorComponent.Gradient.start, ColorComponent.Gradient.end], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 1.0, y: 0.0))
                applyBackgroundGradient(colors:[ColorComponent.Gradient.start.withAlphaComponent(0.1), ColorComponent.Gradient.end.withAlphaComponent(0.1)])
            } else {
                removeBorderLayer()
                removeBackgroundLayer()
            }
        }
    }
    
}

open class ActionButton: ChipButton {
    let rightImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public override func setup() {
        super.setup()
        addSubview(rightImage)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        contentHorizontalAlignment = .left
       
        if #available(iOS 15.0, *) {
            configuration = .plain()
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
        } else {
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        }
        
        NSLayoutConstraint.activate([
            rightImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            rightImage.centerYAnchor
                .constraint(equalTo: self.centerYAnchor),
            rightImage.widthAnchor
                .constraint(equalToConstant: 5),
            rightImage.heightAnchor
                .constraint(equalToConstant: 10)
        ])
    }
}
