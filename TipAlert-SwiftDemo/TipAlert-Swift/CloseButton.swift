//
//  CloseButton.swift
//  TipAlert-SwiftDemo
//
//  Created by 吕俊 on 15/9/30.
//  Copyright © 2015年 Akring. All rights reserved.
//

import UIKit

class CloseButton: UIButton {

    override func draw(_ rect: CGRect) {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color = UIColor(red: 0.881, green: 0.881, blue: 0.881, alpha: 1.000)
        
        //// Group
        context?.saveGState()
        context?.scaleBy(x: 0.5, y: 0.5)
        
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))
        color.setFill()
        ovalPath.fill()
        
        
        //// Rectangle Drawing
        context?.saveGState()
        context?.translateBy(x: 25.5, y: 25)
        context?.rotate(by: -45 * CGFloat(M_PI) / 180)
        
        let rectanglePath = UIBezierPath(rect: CGRect(x: -1.5, y: -15, width: 3, height: 30))
        UIColor.lightGray.setFill()
        rectanglePath.fill()
        
        context?.restoreGState()
        
        
        //// Rectangle 2 Drawing
        context?.saveGState()
        context?.translateBy(x: 25.67, y: 25.33)
        context?.rotate(by: -135 * CGFloat(M_PI) / 180)
        
        let rectangle2Path = UIBezierPath(rect: CGRect(x: -1.5, y: -15, width: 3, height: 30))
        UIColor.lightGray.setFill()
        rectangle2Path.fill()
        
        context?.restoreGState()
        
        
        
        context?.restoreGState()

    }

}
