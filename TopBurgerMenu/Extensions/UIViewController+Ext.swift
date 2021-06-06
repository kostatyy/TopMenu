//
//  UIViewController+Ext.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 05.06.2021.
//

import UIKit

extension UIViewController {
    
    func customizeViewController(navTitle: String) {
        title = navTitle.uppercased()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let menuImage = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .done, target: self, action: nil)
    }
    
    /* Adding Top Menu View */
    func addMenuView(menuView: TopMenuView, controllerContent: UIView) {
        view.addSubview(menuView)
        menuView.addSubview(controllerContent)
    }
}
