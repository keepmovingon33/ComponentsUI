//
//  PracticeNumpadView.swift
//  BaseComponent
//
//  Created by sky on 4/23/22.
//

import UIKit

public protocol PracticeNumpadViewDelegate {
    func numpadTapped(numpadItem: PracticeNumpadItem)
}

public class PracticeNumpadView: BaseView {
    
    var items: [PracticeNumpadItem] = PracticeNumpadItem.createDefaultItems()
    
    public var delegate: PracticeNumpadViewDelegate?
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Spacing.medium
        layout.minimumInteritemSpacing = Spacing.huge
        return layout
    }()
    
    lazy var numpadCollectionView: SelfSizingCollectionView = {
        let collectionView = SelfSizingCollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PracticeNumpadCell.self, forCellWithReuseIdentifier: PracticeNumpadCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
        return collectionView
    }()
    
    public override func setupView() {
        self.addSubview(numpadCollectionView)
        
        NSLayoutConstraint.activate([
            numpadCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            numpadCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            numpadCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numpadCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

extension PracticeNumpadView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = numpadCollectionView.dequeueReusableCell(withReuseIdentifier: PracticeNumpadCell.identifier, for: indexPath) as? PracticeNumpadCell else {
            fatalError("Couldn't find PracticeNumpadCell file")
        }
        cell.bindingData(item: items[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 160) / 3
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.numpadTapped(numpadItem: item)
    }
}
