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
        backgroundColor = BaseColor.main
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = BaseColor.Grey.grey_0.withAlphaComponent(0.5)
//        rippleColor = UIColor(white: 1, alpha: 0.5)
        rippleBackgroundColor = BaseColor.main
        textColor = BaseColor.Grey.grey_100
//        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel?.font = BaseFont.headline
    }
}

open class SecondaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = BaseColor.Grey.grey_0
        cornerRadius = frame.height / 2
        // color for ripple
        
        rippleColor = BaseColor.Indigo.indigo_10
        rippleBackgroundColor = BaseColor.Grey.grey_0
        textColor = BaseColor.Grey.grey_100
//        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel?.font = BaseFont.headline
        borderColor = BaseColor.Grey.grey_100
        borderWidth = 1
    }
}

open class SmallPrimaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = BaseColor.Grey.grey_100
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = BaseColor.Grey.grey_0.withAlphaComponent(0.5)
//        rippleColor = UIColor(white: 1, alpha: 0.5)
        rippleBackgroundColor = BaseColor.Grey.grey_100
        textColor = BaseColor.Grey.grey_0
//        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        titleLabel?.font = BaseFont.footnode.at(weight: .semiBold)
    }
}


open class SmallSecondaryButton: RippleButton {
    public override func setup() {
        super.setup()
        backgroundColor = BaseColor.Grey.grey_0
        cornerRadius = frame.height / 2
        // color for ripple
        rippleColor = BaseColor.Indigo.indigo_5
        rippleBackgroundColor = BaseColor.Grey.grey_0
        textColor = BaseColor.Grey.grey_100
//        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        titleLabel?.font = BaseFont.footnode.strong
        borderColor = BaseColor.Indigo.indigo_20
        borderWidth = 1
    }
}

open class ChipButton: RippleButton {
    public override func setup() {
        if #available(iOS 15.0, *) {
            configuration = .none
        }
        backgroundColor = BaseColor.Grey.grey_0
        cornerRadius = frame.height / 2
//        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel?.font = BaseFont.headline
        backgroundColor = BaseColor.Grey.grey_5
        borderColor = BaseColor.Indigo.indigo_10
        borderWidth = 1
        textColor = BaseColor.Grey.grey_100
        setTitleColor(BaseColor.Gradient.start, for: .selected)
        tintColor = .clear
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }
    
    @objc func didButtonTapped(_ sender: UIButton) {
        isSelected = !isSelected
    }
    
    open override var isSelected: Bool {
        didSet {
            if isSelected {
                gradientBorder(width: 2.0, colors: [BaseColor.Gradient.start, BaseColor.Gradient.end], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 1.0, y: 0.0))
                applyBackgroundGradient(colors:[BaseColor.Gradient.start.withAlphaComponent(0.1), BaseColor.Gradient.end.withAlphaComponent(0.1)])
            } else {
                removeBorderLayer()
                removeBackgroundLayer()
            }
        }
    }
    
}

open class ActionButton: ChipButton {
    let rightImage: UIImageView = {
        let imageView = UIImageView(image: ImageProvider.image(named: "ic_chevron_right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public override func setup() {
        super.setup()
        addSubview(rightImage)
//        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel?.font = BaseFont.subHeadline
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
