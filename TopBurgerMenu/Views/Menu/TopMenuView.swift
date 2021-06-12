//
//  TopMenuView.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 06.06.2021.
//

import UIKit

class TopMenuView: UIView {
    
    // Sections Collection View
    var menuSectionsCollectionView: TopMenuCollectionView!
    private var selectedScreenTitle: ScreentTitle
    
    init(frame: CGRect, screenTitle: ScreentTitle) {
        
        self.selectedScreenTitle = screenTitle
        
        super.init(frame: frame)
        
        setupViews()
        setupCollectionView()
    }
    
    private func setupViews() {
        setGradientFill(colorTop: .gradientColorTop, colorBottom: .gradientColorBottom, cornerRadius: 30, startPoint: CGPoint(x: 0.5, y: 1.0), endPoint: CGPoint(x: 0.5, y: 0.0), opacity: 1)
    }
    
    // MARK: - Setting Up Sections Collection View
    private func setupCollectionView() {
        menuSectionsCollectionView = TopMenuCollectionView()
        menuSectionsCollectionView.backgroundColor = .clear
        menuSectionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(menuSectionsCollectionView)
        
        NSLayoutConstraint.activate([
            menuSectionsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            menuSectionsCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuSectionsCollectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            menuSectionsCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TopMenuView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToCenter()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapToCenter()
        }
    }
    
    func snapToCenter() {
        let centerPoint =  self.convert(self.center, to: menuSectionsCollectionView)
        guard let centerIndexPath = menuSectionsCollectionView.indexPathForItem(at: centerPoint) else { return }
        menuSectionsCollectionView.scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
    }
    
}
