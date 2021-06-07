//
//  TopMenuLayout.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 07.06.2021.
//

import UIKit

class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {
    
    let activeDistance: CGFloat = 200
    let zoomFactor: CGFloat = 0.3
    let numberOfItemsPerPage: CGFloat = 1
    let velocityPerPage: CGFloat = 2
    
    // Cell Size Vars
    let itemWidth = UIScreen.main.bounds.width * 0.9
    let itemHeight = UIScreen.main.bounds.height * 0.1
    
    override init() {
        super.init()
        
        scrollDirection = .vertical
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        minimumLineSpacing = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        
        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midY - attributes.center.y
            let normalizedDistance = distance / activeDistance
            
            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }
        
        return rectAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        var pageLength: CGFloat
        var approxPage: CGFloat
        var currentPage: CGFloat
        var speed: CGFloat
        
        pageLength = (self.itemSize.height + self.minimumLineSpacing) * numberOfItemsPerPage
        approxPage = collectionView.contentOffset.y / pageLength
        speed = velocity.y
        
        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }
        
        guard speed != 0 else {
            return CGPoint(x: 0, y: currentPage * pageLength)
        }
        
        var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)
        
        let increment = speed / velocityPerPage
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)
        
        return CGPoint(x: 0, y: nextPage * pageLength)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }
    
}
