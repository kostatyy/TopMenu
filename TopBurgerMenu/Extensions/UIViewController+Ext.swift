//
//  UIViewController+Ext.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 05.06.2021.
//

import UIKit

private var contentRadiusFactor: CGFloat!
private var contentRadiusMax: CGFloat = 30
private var contentYPosMax: CGFloat = UIScreen.main.bounds.height / 2
private var menuShow: Bool = false

extension UIViewController {
    
    func customizeViewController(navTitle: String) {
        title = navTitle.uppercased()
        navigationController?.navigationBar.alpha = 1
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @objc private func handleMenuButton(contentView: UIView) {
        var menuShow = false
        goToMenu(contentView: contentView, menuShow: &menuShow, withAnimation: true)
    }
    
    /* Adding Top Menu View */
    func addMenuView(menuView: TopMenuView, menuShow: inout Bool, isChoosen: Bool, controllerContent: UIView) {
        view.addSubview(menuView)
        menuView.addSubview(controllerContent)
        
        
        if isChoosen { // If Screen Is Choosen From Menu
            goToMenu(contentView: controllerContent, menuShow: &menuShow, withAnimation: false) // Leave Menu Open
            goToMenu(contentView: controllerContent, menuShow: &menuShow, withAnimation: true) // Close Menu
        }
        
        let menuImage = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .done, target: #selector(handleMenuButton), action: nil)
    }
    
    /* Open / Close menu */
    func goToMenu(contentView: UIView, menuShow: inout Bool, withAnimation: Bool) {
        menuShow.toggle()
        
        var t = CGAffineTransform.identity
        let scaleCoef: CGFloat = menuShow ? min(300 / abs(contentYPosMax), 1) : 1.0
        let cornerRadius: CGFloat = menuShow ? 30 : 0
        t = t.translatedBy(x: 0, y: menuShow ? (self.view.center.y + contentYPosMax * 0.99) - contentView.frame.height / 2 : 0)
        t = t.scaledBy(x: scaleCoef, y: scaleCoef)

        if menuShow {
            contentView.layer.cornerRadius = cornerRadius
            UIView.animate(withDuration: withAnimation ? 0.5 : 0, delay: 0, usingSpringWithDamping: withAnimation ? 0.5 : 0, initialSpringVelocity: 0, options: .curveEaseInOut) {
                contentView.transform = t
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                contentView.transform = t
            } completion: { (_) in
                contentView.layer.cornerRadius = cornerRadius
            }
        }
    }
    
    //MARK: - Handling Pan Gesture To Slide Top Menu
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        contentRadiusFactor = (view.frame.width / 2) / contentRadiusMax
        let content = sender.view
        let point = sender.translation(in: self.view)
        var yFromCenter = (content?.center.y)! - view.center.y
        var scale = min(300 / abs(yFromCenter), 1) // Content view
        let alphaPercentage: CGFloat = yFromCenter / view.frame.size.height * 2 // Navigation Alpha %
                
        if sender.state == .began || sender.state == .changed {
            if (yFromCenter <= contentYPosMax && yFromCenter >= 0) {
                content?.center = CGPoint(x: view.center.x, y: content!.center.y + point.y)
                content?.transform = CGAffineTransform(scaleX: scale, y: scale)
                content?.layer.cornerRadius = yFromCenter / contentRadiusFactor
                navigationController?.navigationBar.alpha = 1 - alphaPercentage
            }
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
        
        if sender.state == .ended {
            if yFromCenter > view.center.y * 0.2 { // Open Menu
                yFromCenter = contentYPosMax
                scale = min(300 / abs(yFromCenter), 1)
                
                UIView.animate(withDuration: 0.2) {
                    content?.layer.cornerRadius = contentRadiusMax
                    content?.center = CGPoint(x: self.view.center.x, y: self.view.center.y + contentYPosMax * 0.99)
                    content?.transform = CGAffineTransform(scaleX: scale, y: scale)
                    self.navigationController?.navigationBar.alpha = 0
                } completion: { (_) in
                    menuShow = true
                }

            } else { // Close Menu
                UIView.animate(withDuration: 0.2) {
                    content?.layer.cornerRadius = 0
                    content?.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
                    content?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.navigationController?.navigationBar.alpha = 1
                } completion: { (_) in
                    menuShow = false
                }
            }
        }
    }
    
    //MARK: - Handling Tap On Content View To Close Menu
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        let content = sender.view
        if menuShow {
            UIView.animate(withDuration: 0.2) {
                content?.layer.cornerRadius = 0
                content?.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
                content?.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.navigationController?.navigationBar.alpha = 1
            } completion: { (_) in
                menuShow = false
            }
        }
    }
    
    //MARK: - Notification Observer For Going To Selected Screen
    @objc func goToSectionFromMenu(notification: NSNotification) {
        guard let sectionName = notification.userInfo?["sectionIndex"] as? ScreentTitle else {return}
        print(sectionName)
        goToScreen(sectionName: sectionName)
    }
    
    //MARK: - Go To Selected Section From Menu
    func goToScreen(sectionName: ScreentTitle) {
        var vc: BaseViewControllerProtocol
        switch sectionName {
        case .Profile:
            vc = ProfileViewController()
        case .Groups:
            vc = GroupsViewController()
        case .Chats:
            vc = ChatsViewController()
        case .Friends:
            vc = FriendsViewController()
        case .Settings:
            vc = SettingsViewController()
        }
        vc.isChoosen = true
        navigationController?.pushViewController(vc as! UIViewController, animated: false)
    }
}
