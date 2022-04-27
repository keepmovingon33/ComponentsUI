//
//  PracticeNumpadCell.swift
//  BaseComponent
//
//  Created by sky on 4/23/22.
//

import UIKit

public class PracticeNumpadCell: UICollectionViewCell {
    var item: PracticeNumpadItem?
    
    static let identifier = "PracticeNumpadCell"
    
    lazy var roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BaseColor.Grey.grey_5
        return view
    }()
    
    lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var inputImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = BaseColor.Grey.grey_100
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        self.addSubview(roundedView)
        self.addSubview(inputLabel)
        self.addSubview(inputImageView)
        
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: self.topAnchor),
            roundedView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            roundedView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            roundedView.heightAnchor.constraint(equalTo: self.widthAnchor),
            roundedView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            inputLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inputLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            inputImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inputImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            inputImageView.heightAnchor.constraint(equalToConstant: Spacing.huge),
            inputImageView.widthAnchor.constraint(equalToConstant: Spacing.huge)
        ])
        
        roundedView.cornerRadius = self.bounds.width / 2
    }
    
    func bindingData(item: PracticeNumpadItem) {
        self.item = item
        if item.type == .numpad {
            guard let value = item.inputValue else { return }
            inputLabel.attributedText = NSAttributedString(string: value, typesetting: Typesetting.smallTitle.at(color: BaseColor.Grey.grey_100))
            inputImageView.isHidden = true
        } else {
            roundedView.backgroundColor = .clear
            inputLabel.isHidden = true
            inputImageView.image = item.image
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            guard let item = item else { return }
            
            UIView.animate(withDuration: 0.2) {
                if item.type == .numpad {
                    self.roundedView.backgroundColor = self.isHighlighted ? item.type.getNumpadHighLightColor().highlight : item.type.getNumpadHighLightColor().normal
                } else {
                    self.inputImageView.tintColor = self.isHighlighted ? item.type.getTintColorImageView().highlight : item.type.getTintColorImageView().normal
                }
                
            }
        }
    }
}

public struct HightLightColor {
    let highlight: UIColor
    let normal: UIColor
}

public struct PracticeNumpadItem {
    var inputValue: String?
    var image: UIImage?
    var type: PracticeNumpadType
    
    static func createDefaultItems() -> [PracticeNumpadItem] {
        return [
            PracticeNumpadItem(inputValue: "1", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: "2", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: "3", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: "4", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: "5", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: "6", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: "7", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: "8", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: "9", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: nil, image: ImageProvider.image(named: "ic_bio_touchID"), type: .bio),
            PracticeNumpadItem(inputValue: "0", image: nil, type: .numpad),
            PracticeNumpadItem(inputValue: nil, image: ImageProvider.image(named: "ic_backspace"), type: .delete)
        ]
    }
}

public enum PracticeNumpadType {
    case numpad
    case delete
    case bio
    
    func getNumpadHighLightColor() -> HightLightColor {
        return HightLightColor(highlight: BaseColor.Indigo.indigo_10, normal: BaseColor.Grey.grey_5)
    }
    
    func getTintColorImageView() -> HightLightColor {
        return HightLightColor(highlight: BaseColor.Grey.grey_100.withAlphaComponent(0.3), normal: BaseColor.Grey.grey_100)
    }
}
