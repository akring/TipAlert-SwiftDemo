//
//  CloseButton.swift
//  TipAlert-SwiftDemo
//
//  Created by 吕俊 on 15/9/30.
//  Copyright © 2015年 Akring. All rights reserved.
//

import UIKit

class CloseButton: UIButton {

    override func drawRect(rect: CGRect) {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color = UIColor(red: 0.881, green: 0.881, blue: 0.881, alpha: 1.000)
        
        //// Group
        CGContextSaveGState(context)
        CGContextScaleCTM(context, 0.5, 0.5)
        
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 50, 50))
        color.setFill()
        ovalPath.fill()
        
        
        //// Rectangle Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 25.5, 25)
        CGContextRotateCTM(context, -45 * CGFloat(M_PI) / 180)
        
        let rectanglePath = UIBezierPath(rect: CGRectMake(-1.5, -15, 3, 30))
        UIColor.lightGrayColor().setFill()
        rectanglePath.fill()
        
        CGContextRestoreGState(context)
        
        
        //// Rectangle 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 25.67, 25.33)
        CGContextRotateCTM(context, -135 * CGFloat(M_PI) / 180)
        
        let rectangle2Path = UIBezierPath(rect: CGRectMake(-1.5, -15, 3, 30))
        UIColor.lightGrayColor().setFill()
        rectangle2Path.fill()
        
        CGContextRestoreGState(context)
        
        
        
        CGContextRestoreGState(context)

    }

}
