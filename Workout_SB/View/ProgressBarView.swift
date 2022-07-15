//
//  ProgressBarView.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 8/18/21.
//

import UIKit

//@IBDesignable
class ProgressBarView: UIView {
    
    @IBInspectable var color: UIColor? = .gray
    var progress: CGFloat = 0.5 {
        didSet {setNeedsDisplay()}
    }
    private let progressLayer = CALayer()

    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: 9).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        
        progressLayer.frame = progressRect
        
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = color?.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(progressLayer)
    }
    

}
