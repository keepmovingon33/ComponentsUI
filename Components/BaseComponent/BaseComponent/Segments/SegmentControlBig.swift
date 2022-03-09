//
//  SegmentControlBig.swift
//  BaseComponent
//
//  Created by sky on 3/8/22.
//

import UIKit

public class SegmentControlBig: SegmentControl {
    public var padding: CGFloat = 8
    
    public override func initView() {
        // do nothing in segment control big. minh override de no ko phai function giong nhu thang segmentControl
    }
    
    public override func makeButton(title: String, icon: UIImage?, iconAlignment: UISemanticContentAttribute) -> UIButton {
        let button = super.makeButton(title: title, icon: icon, iconAlignment: iconAlignment)
        button.borderColor = segmentBorderColor
        button.borderWidth = 1
        button.cornerRadius = self.bounds.height / 2
        return button
    }
    
    public override func layoutItem() {
        // khi minh tap button, chi thay doi x, ko thay doi y
        // CGFloat la tham so de set cho UI voi cac gia tri x,y,z, width, height
        var xPosition: CGFloat = 0
        let height = self.bounds.height
        let bigWidth = self.bounds.width * 2 / 3
        let smallWidth = self.bounds.width - bigWidth - padding
        
        for button in buttons {
            let width = button.isSelected ? bigWidth : smallWidth
            button.frame = CGRect(x: xPosition, y: 0, width: width, height: height)
            xPosition = button.frame.maxX + padding
        }
    }
    
    public override func selectItem(index: Int, animated: Bool = true) {
        guard index < buttons.count else { return }
        
        let selectedButton = buttons[index]
        UIView.animate(withDuration: animated ? 0.3 : 0, delay: 0, options: .curveEaseInOut) { [unowned self] in
            self.buttons.forEach { button in
                if button != selectedButton {
                    button.isSelected = false
                    button.backgroundColor = normalBackgroundColor
                } else {
                    button.isSelected = true
                    button.backgroundColor = selectedBackgroundColor
                }
            }
            layoutItem()
        }
    }
}
