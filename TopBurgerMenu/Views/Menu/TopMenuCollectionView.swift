//
//  TopMenuCollectionView.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 06.06.2021.
//

import UIKit

class TopMenuCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /* Fade Effect Variables */
    private let fadePercentage: Double = 0.4
    private let gradientLayer = CAGradientLayer()
    private let transparentColor = UIColor.clear.cgColor
    private let opaqueColor = UIColor.black.cgColor
    
    private var bottomOpacity: CGColor {
        let alpha: CGFloat = 0
        
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    private let sectionNames = ["Profile", "Groups", "Chats", "Friends", "Settings"]
    private let sectionsCount = 5
    
    init() {
        let layout = ZoomAndSnapFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsVerticalScrollIndicator = false
        
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(MenuSectionCell.self, forCellWithReuseIdentifier: MenuSectionCell.reuseId)
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSectionCell.reuseId, for: indexPath) as! MenuSectionCell
        cell.backgroundColor = .clear
        cell.sectionName.text = sectionNames[indexPath.row]
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
