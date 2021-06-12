//
//  TopMenuCollectionView.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 06.06.2021.
//

import UIKit

class TopMenuCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    /* Fade Effect Variables */
    private let fadePercentage: Double = 0.4
    private let gradientLayer = CAGradientLayer()
    private let transparentColor = UIColor.clear.cgColor
    private let opaqueColor = UIColor.black.cgColor
    private var bottomOpacity: CGColor {
        let color = UIColor(white: 0, alpha: 0)
        return color.cgColor
    }
    
    private let sectionNames = ScreentTitle.allCases
    private let sectionsCount = ScreentTitle.allCases.count
    
    init() {
        let layout = TopMenuLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        showsVerticalScrollIndicator = false
        
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(MenuSectionCell.self, forCellWithReuseIdentifier: MenuSectionCell.reuseId)
    }
    
    // Adding Fade Effect
    override func layoutSubviews() {
        super.layoutSubviews()

        self.delegate = self
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds

        gradientLayer.frame = CGRect(x: self.bounds.origin.x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        gradientLayer.colors = [bottomOpacity, opaqueColor, opaqueColor, bottomOpacity]
        gradientLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]
        maskLayer.addSublayer(gradientLayer)

        self.layer.mask = maskLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TopMenuCollectionView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSectionCell.reuseId, for: indexPath) as! MenuSectionCell
        cell.backgroundColor = .clear
        cell.sectionName.text = sectionNames[indexPath.row].stringValue
        return cell
    }

    // Scroll To Cell By Tapping On It
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        
//        let layout = collectionView.collectionViewLayout as! TopMenuLayout
//        let pageLength = layout.itemSize.height + layout.minimumLineSpacing
//        
//        setContentOffset(CGPoint(x: 0, y: Int(pageLength) * indexPath.row), animated: true)
        
        let sectionInfo: [String: ScreentTitle] = ["sectionIndex": sectionNames[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SectionChangeTap"), object: nil, userInfo: sectionInfo)
    }
}
