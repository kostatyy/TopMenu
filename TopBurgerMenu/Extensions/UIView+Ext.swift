//
//  UIView+Ext.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 06.06.2021.
//

import UIKit

extension UIView {
    
    /* Setting bg gradient */
    func setGradientFill(colorTop: UIColor, colorBottom: UIColor, cornerRadius: CGFloat, startPoint: CGPoint, endPoint: CGPoint, opacity: Float) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.opacity = opacity
        gradientLayer.frame = self.bounds
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
