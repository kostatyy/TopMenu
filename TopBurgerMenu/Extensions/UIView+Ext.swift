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
    
    func setupShadow(cornerRad: CGFloat, shadowRad: CGFloat, shadowOp: Float, offset: CGSize) {
        self.layer.cornerRadius = cornerRad
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadowRad
        self.layer.shadowOpacity = shadowOp
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    enum Edge {
        case top
        case bottom
        case left
        case right
    }

    func pinToEdges(edges: [Edge] = [.top, .bottom, .left, .right], constant: CGFloat = 0) {
        guard let superview = superview else {return}
        edges.forEach {
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            }
        }
    }
}
