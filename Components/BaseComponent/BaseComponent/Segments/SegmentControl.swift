//
//  SegmentControl.swift
//  BaseComponent
//
//  Created by sky on 3/7/22.
//

import UIKit

@IBDesignable
public class SegmentControl: UIView {
    
    // MARK: - Inspectable Variable
    @IBInspectable var normalTitleColor: UIColor = BaseColor.Grey.grey_100
    @IBInspectable var selectedTitleColor: UIColor = BaseColor.Grey.grey_0
    @IBInspectable var selectedBackgroundColor: UIColor = BaseColor.Grey.grey_100
    @IBInspectable var normalBackgroundColor: UIColor = BaseColor.Grey.grey_5
    @IBInspectable var segmentBorderColor: UIColor = BaseColor.Indigo.indigo_10
    
    // MARK: - PUBLIC PROPERTIES
    // minh ko chinh font label thanh Inspectable dc
    public var fontTitle: UIFont = BaseFont.subHeadline
    
    // MARK: - PRIVATE PROPERTIES
    private var didSelected: ((Int) -> Void)?
    
    // MARK: - UI Variables
    private var buttons: [UIButton] = []
    // thumbView la view khi minh select vao thi no se chay tu trai sang phai hay nguoc lai
    private var thumbView: UIView!
    
    // init cho code tay
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    // init cho xib file
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initView()
    }
    
    // reload lai UI, cap nhat frame
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutItem()
    }
    
    // set UIView cho segment va thumbView
    private func initView() {
        thumbView = UIView(frame: self.bounds)
        thumbView.backgroundColor = selectedBackgroundColor
        self.addSubview(thumbView)
        self.backgroundColor = normalBackgroundColor
        self.borderColor = segmentBorderColor
        self.borderWidth = 1
        
        // khi minh border thi ko muon no bi trao ra ngoai
        self.layer.masksToBounds = true
    }
    
    private func makeButton(title: String, icon: UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalTitleColor, for: .normal)
        button.setTitleColor(selectedTitleColor, for: .selected)
        button.titleLabel?.font = fontTitle
        button.setImage(icon, for: .selected)
        button.imageView?.tintColor = selectedTitleColor
        button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        // set image padding
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }
    
    // set frame, position cua items cho UI
    private func layoutItem() {
        // khi minh tap button, chi thay doi x, ko thay doi y
        // CGFloat la tham so de set cho UI voi cac gia tri x,y,z, width, height
        var xPosition: CGFloat = 0
        let height = self.bounds.height
        let width = self.bounds.width / CGFloat(buttons.count)
        thumbView.frame = CGRect(x: xPosition, y: 0, width: width, height: height)
        
        for button in buttons {
            button.frame = CGRect(x: xPosition, y: 0, width: width, height: height)
            xPosition = button.frame.maxX
            if button.isSelected {
                // thumbView se chay tu vi tri dang selected sang vi tri selected moi
                thumbView.center = button.center
            }
        }
        
        // set corner radius for button
        thumbView.cornerRadius = self.bounds.height / 2
        self.cornerRadius = self.bounds.height / 2
    }
    
    @objc private func handleTap(_ sender: UIButton) {
        if let index = buttons.firstIndex(of: sender) {
            // handle closure tap vo selected button
            didSelected?(index)
            
            selectItem(index: index)
        }
    }
    
    // khi minh tap vao 1 button, minh muon chay animation de thumbView chay toi vi tri moi, va cap nhat button status (normal or selected)
    private func selectItem(index: Int, animated: Bool = true) {
        guard index < buttons.count else { return }
        
        let selectedButton = buttons[index]
        UIView.animate(withDuration: animated ? 0.3 : 0, delay: 0, options: .curveEaseInOut) { [unowned self] in
            self.thumbView.center = selectedButton.center
        } completion: { [unowned self] _ in
            self.buttons.forEach { button in
                if button != selectedButton {
                    button.isSelected = false
                } else {
                    button.isSelected = true
                }
            }
        }

    }
    
    public func setItems(items: [(title: String, icon: UIImage?)], completion: ((Int) -> Void)?) {
        // truyen closure de khi user taps on button, minh se handle action do
        didSelected = completion
        // remove het buttons ra khoi UI
        buttons.forEach { $0.removeFromSuperview() }
        // remove het button items trong buttons
        buttons.removeAll()
        for item in items {
            let button = makeButton(title: item.title, icon: item.icon)
            addSubview(button)
            buttons.append(button)
        }
        // cai nay fix bug khi moi run first time, title color ko co update
        selectItem(index: 0, animated: false)
        // func nay reload lai UI, upload frame cho UIView, giong nhu trong UITableView co func tableView.reloadData()
        self.setNeedsLayout()
        
    }
}
