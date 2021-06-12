//
//  GroupsViewController.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 05.06.2021.
//

import UIKit

class GroupsViewController: UIViewController, BaseViewControllerProtocol {

    private var topMenu: TopMenuView!
    private var contentView: ContentView!
    private var sectionTitle: ScreentTitle = .Groups
    
    var isChoosen: Bool = false
    var menuShow: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeViewController(navTitle: "Groups")
        
        setupContent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToSectionFromMenu(notification:)), name: NSNotification.Name(rawValue: "SectionChangeTap"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let collectionView = topMenu.menuSectionsCollectionView!
        
        let layout = collectionView.collectionViewLayout as! TopMenuLayout
        let pageLength = layout.itemSize.height + layout.minimumLineSpacing
        
        topMenu.menuSectionsCollectionView.setContentOffset(CGPoint(x: 0, y: Int(pageLength) * sectionTitle.index), animated: false)
    }

    // Setting Up Content And Top Menu
    private func setupContent() {
        topMenu = TopMenuView(frame: view.frame, screenTitle: sectionTitle)
        contentView = ContentView(frame: view.frame, bgColor: .groupsBgColor)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))

        contentView.gestureRecognizers = [panGestureRecognizer, tapGestureRecogniser]
        
        addMenuView(menuView: topMenu, menuShow: &menuShow, isChoosen: isChoosen, controllerContent: contentView)
    }
}
