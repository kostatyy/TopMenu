//
//  ContentView.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 07.06.2021.
//

import UIKit

class ContentView: UIView {
    
    init(frame: CGRect, bgColor: UIColor) {
        
        super.init(frame: frame)
        setupMenu(bgColor: bgColor)
    }
    
    /* Setting Up Menu */
    private func setupMenu(bgColor: UIColor) {
        backgroundColor = bgColor
        setupShadow(cornerRad: 30, shadowRad: 15, shadowOp: 0.3, offset: CGSize(width: 5, height: 5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
