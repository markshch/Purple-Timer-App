//
//  ShadowView.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 8/7/21.
//

import UIKit

class ShadowView: UIView {

    var setupShadowDone: Bool = false
    
    public func setupShadow() {
        
        switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 4.5
                self.layer.shadowOpacity = 0.3
            case .dark:
                self.layer.shadowColor = UIColor.blue.cgColor
                self.layer.shadowOpacity = 0.95
                ///To remove DARK MODE shadow, uncomment below -- Also see DisplayTableViewCell traitCollectionDidChange
                self.layer.shadowOpacity = 0.00  //no shadow
                self.layer.shadowRadius = 6
        @unknown default:
            self.layer.shadowColor = UIColor.blue.cgColor
            
        }
        
//        if setupShadowDone { return }
        
        self.layer.cornerRadius = 25
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowRadius = 3
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 25, height: 25)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    
        setupShadowDone = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.setNeedsUpdateConstraints()
//        self.setNeedsLayout()
//        self.setNeedsDisplay()
        
        setupShadow()
    }
    
    public func darkModeShadow() {
        
    }
}
