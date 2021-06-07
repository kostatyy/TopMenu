//
//  MenuSectionCell.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 06.06.2021.
//

import UIKit

class MenuSectionCell: UICollectionViewCell {
    
    static var reuseId: String = "SectionsCollectionViewId"
    var sectionName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        sectionName.font = UIFont.setFont(size: .ExtraLarge, weight: .Bold)
        sectionName.textColor = .white
        sectionName.textAlignment = .center
        sectionName.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sectionName)
        sectionName.pinToEdges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
