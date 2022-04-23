//
//  BaseNumpadKeyboardView.swift
//  BaseComponent
//
//  Created by sky on 4/20/22.
//

import UIKit

public protocol BaseNumpadKeyboardViewDelegate {
    func numpadTapped(value: String)
}

public class BaseNumpadKeyboardView: BaseView {
    
    private let numpadItems = NumpadItem.defaultValue()
    
    public var delegate: BaseNumpadKeyboardViewDelegate?
    
    // cai nay de setup layout collectionview, vi du padding giua cac item, hoac direction scroll
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // layout giua 2 item
        layout.minimumInteritemSpacing = Spacing.huge
        // layout giua 2 dong
        layout.minimumLineSpacing = Spacing.medium
        return layout
    }()
    
    lazy var numpadCollectionView: SelfSizingCollectionView = {
        let collectionView = SelfSizingCollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NumpadKeyboardCellItem.self, forCellWithReuseIdentifier: NumpadKeyboardCellItem.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        // set padding 4 goc
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
        return collectionView
    }()
    
    public override func setupView() {
        self.addSubview(numpadCollectionView)
    
        NSLayoutConstraint.activate([
            numpadCollectionView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            numpadCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numpadCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            numpadCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension BaseNumpadKeyboardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumpadKeyboardCellItem.identifier, for: indexPath) as? NumpadKeyboardCellItem else {
            fatalError("Couldn't find NumpadKeyboardCellItem")
        }
        
        cell.bindingData(item: numpadItems[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numpadItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 160) / 3
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = numpadItems[indexPath.row]
        let value = item.value ?? (item.type == .biometric ? "bio" : "delete")
        
        HapticFeedback.light.run()
        
        delegate?.numpadTapped(value: value)
    }
}
