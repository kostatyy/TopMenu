//
//  ProfileViewController.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 05.06.2021.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var topMenu: TopMenuView!
    private var contentView: UIView!
    
    private var contentRadiusFactor: CGFloat!
    private var contentRadiusMax: CGFloat = 30
    private var contentYPosMax: CGFloat = UIScreen.main.bounds.height / 3
    
    private var menuShow: Bool = false
    private var savedPoint: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeViewController(navTitle: "Profile")
        
        contentRadiusFactor = (view.frame.width / 2) / contentRadiusMax
        setupMenu()
    }
    
    /* Setting Up Menu */
    private func setupMenu() {
        topMenu = TopMenuView(frame: view.frame)
        contentView = UIView(frame: view.frame)
        contentView.backgroundColor = .profileBgColor
        addMenuView(menuView: topMenu, controllerContent: contentView)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        contentView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        let content = sender.view
        let point = sender.translation(in: self.view)
        var yFromCenter = (content?.center.y)! - view.center.y
        var scale = min(200 / abs(yFromCenter), 1)
                
        if sender.state == .began || sender.state == .changed {
            if (yFromCenter <= contentYPosMax && yFromCenter >= 0) {
                content?.center = CGPoint(x: view.center.x, y: content!.center.y + point.y)
                content?.transform = CGAffineTransform(scaleX: scale, y: scale)
                content?.layer.cornerRadius = yFromCenter / contentRadiusFactor
            }
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
        
        if sender.state == .ended {
            print(point.y)
            if yFromCenter > view.center.y * 0.2 {
                yFromCenter = contentYPosMax
                scale = min(200 / abs(yFromCenter), 1)
                
                UIView.animate(withDuration: 0.2) {
                    content?.layer.cornerRadius = self.contentRadiusMax
                    content?.center = CGPoint(x: self.view.center.x, y: self.view.center.y + self.contentYPosMax * 0.99)
                    content?.transform = CGAffineTransform(scaleX: scale, y: scale)
                } completion: { (_) in
                    self.menuShow = true
                    self.savedPoint = point
                }

            } else {
                UIView.animate(withDuration: 0.2) {
                    content?.layer.cornerRadius = 0
                    content?.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
                    content?.transform = CGAffineTransform(scaleX: 1, y: 1)
                } completion: { (_) in
                    self.menuShow = false
                    self.savedPoint = nil
                }
            }
        }
    }

}

