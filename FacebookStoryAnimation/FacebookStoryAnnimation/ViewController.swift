//
//  ViewController.swift
//  FacebookStoryAnnimation
//
//  Created by Ahmed masoud on 5/5/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    let colors: [UIColor] = [.red, .blue, .green, .purple, .black, .cyan]
    // Card Width
    let width: CGFloat = 100
    let minimumWidth: CGFloat = 50
    // Card Height
    let height: CGFloat = 150
    let minimumHeight: CGFloat = 50
    // Card Padding
    let leadingPaddingFactor: CGFloat = 0.2
    let leadingMinimumPadding: CGFloat = 0
    // Collection Padding
    let padding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myCollection.clipsToBounds = false
        if let layout = myCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = myCollection.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as! MyCardCollectionHeader
        let offset = scrollView.contentOffset.x
        let semicircularRadius = headerView.myCard.frame.height / 2
        let heightToWidth: CGFloat = height / width
        
        // Width
        var newWidth: CGFloat = width - offset
        newWidth = newWidth > minimumWidth ? width - offset : minimumWidth
        
        // Height
        var newHeight = (height - offset * heightToWidth)
        newHeight =  newHeight > minimumHeight ? newHeight : minimumHeight
        
        // Top Spacing
        var topSpacing = (offset * heightToWidth) / 2
        let maximumTopSpacing = (height/2) - (newHeight/2)
        topSpacing = topSpacing < maximumTopSpacing ? topSpacing : maximumTopSpacing
        
        // Corner Radius
        let relativeSwipedRadius = offset * heightToWidth
        let radius = semicircularRadius > relativeSwipedRadius ? relativeSwipedRadius : semicircularRadius
        headerView.myCard.roundCorners(.init([.layerMaxXMinYCorner,.layerMaxXMaxYCorner]), radius: radius)
        
        // Leading Spacing
        var leadingSpacing = padding - offset * leadingPaddingFactor
        leadingSpacing = leadingSpacing > leadingMinimumPadding ? leadingSpacing : leadingMinimumPadding
        
        // Update Header Frame
        headerView.myCard.frame = CGRect(x: leadingSpacing, y: topSpacing, width: newWidth, height: newHeight)
        
        headerView.layoutIfNeeded()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(MyCardCollectionHeader.self)", for: indexPath) as! MyCardCollectionHeader
            headerView.myCard.backgroundColor = .gray
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    
    
}


class MyCardCollectionHeader : UICollectionReusableView {
    @IBOutlet weak var myCard: UIView!
}


extension UIView {
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
