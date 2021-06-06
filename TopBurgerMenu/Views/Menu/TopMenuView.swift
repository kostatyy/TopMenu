//
//  TopMenuView.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 06.06.2021.
//

import UIKit

class TopMenuView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        setGradientFill(colorTop: .gradientColorTop, colorBottom: .gradientColorBottom, cornerRadius: 30, startPoint: CGPoint(x: 0.5, y: 1.0), endPoint: CGPoint(x: 0.5, y: 0.0), opacity: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
