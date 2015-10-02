//
//  TipAlert.swift
//  TipAlert-SwiftDemo
//
//  Created by 吕俊 on 15/9/30.
//  Copyright © 2015年 Akring. All rights reserved.
//

import UIKit

// MARK: - 转换RGB颜色
func getColor(hexColor:NSString) ->UIColor{
    
    var redInt:UInt32 = 0
    var greenInt:UInt32 = 0
    var blueInt:UInt32 = 0
    var rangeNSRange:NSRange! = NSMakeRange(0, 0)
    rangeNSRange.length = 2
    
    //取红色值
    rangeNSRange.location = 0
    NSScanner(string: hexColor.substringWithRange(rangeNSRange)).scanHexInt(&redInt)
    
    //取绿色值
    rangeNSRange.location = 2
    NSScanner(string: hexColor.substringWithRange(rangeNSRange)).scanHexInt(&greenInt)
    
    //取蓝色值
    rangeNSRange.location = 4
    NSScanner(string: hexColor.substringWithRange(rangeNSRange)).scanHexInt(&blueInt)
    
    let red = CGFloat(redInt)/255.0
    let green = CGFloat(greenInt)/255.0
    let blue = CGFloat(blueInt)/255.0
    let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
    
    return color
}

let ALERT_WIDTH = 241
let TITLE_VIEW_BG_COLOR = "e8e8e8"
let TITLE_LABEL_COLOR = "184c85"
let ALERT_CONTEXT_COLOR = "686868"

typealias AcceptBlock = ()->Void  //接受Block
typealias DenyBlock = () ->Void   //拒绝Block

class TipAlert: UIView {

    var btnTitleArr:NSArray /**< 按钮标题数组，传入两个即可 */
    var topImage:UIImage?    /**< 顶部图片 */
    let contextStr:String    /**< 内容 */
    let alignment:NSTextAlignment
    var acceptBlock:AcceptBlock? = nil
    var denyBlock:DenyBlock? = nil
    
    private var bgImageView:UIImageView? = nil
    private var contextLabel:UILabel? = nil
    private var alertSize:CGSize? = nil
    
    // MARK: - 初始化方法
    
    init(message:String,image:UIImage,buttonArray:NSArray){
        
        let rect = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), CGRectGetHeight(UIScreen.mainScreen().bounds)+20)
        
        btnTitleArr = buttonArray
        topImage = image
        contextStr = message
        alertSize = CGSizeMake(rect.size.width-60, rect.size.width-60)
        alignment = NSTextAlignment.Center
        
        super.init(frame: rect)
        
        let bgView = UIView(frame: rect)
        bgView.backgroundColor = UIColor.blackColor()
        bgView.alpha = 0.8
        self.addSubview(bgView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 创建Alert体
    /**
    创建Alert主体
    */
    private func addAlertImages(){
        
        let bgRect = CGRectMake(0, 0, (alertSize?.width)!, (alertSize?.height)!)
        
        bgImageView = UIImageView()
        bgImageView!.backgroundColor = UIColor.whiteColor()
        bgImageView!.frame = bgRect
        bgImageView!.userInteractionEnabled = true
        bgImageView!.layer.masksToBounds = true
        bgImageView!.layer.cornerRadius = 10
        bgImageView!.layer.borderColor = UIColor(white: 0.147, alpha: 1).CGColor
        bgImageView!.layer.borderWidth = 1;
        self.addSubview(bgImageView!)
        
        let imageRect = CGRectMake(0, 0, (alertSize?.width)!, (alertSize?.width)!/2)
        let topImageView = UIImageView()
        topImageView.image = topImage
        topImageView.backgroundColor = UIColor.whiteColor()
        topImageView.frame = imageRect
        bgImageView?.addSubview(topImageView)
    }
    /**
    创建文字Label
    */
    private func addAlertLabels(){
        
        let width = (alertSize?.width)!-60
        
        let rect = CGRectMake((CGRectGetWidth((bgImageView?.frame)!)-width)/2, (alertSize?.width)!/2.2, width, (alertSize?.width)!/3)
        
        contextLabel = UILabel(frame: rect)
        contextLabel!.backgroundColor = UIColor.clearColor()
        contextLabel!.textAlignment = alignment
        contextLabel!.textColor = UIColor.blackColor()
        contextLabel!.font = UIFont.systemFontOfSize(15)
        contextLabel!.numberOfLines = 3
        contextLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        contextLabel!.text = contextStr
        
        bgImageView?.addSubview(contextLabel!)
        bgImageView?.center = self.center
    }
    /**
    创建关闭按钮
    */
    private func addCloseBtn(){
        
        let button = CloseButton(type: UIButtonType.System)
        button.frame = CGRectMake(CGRectGetMaxX((bgImageView?.frame)!)-18, CGRectGetMinY((bgImageView?.frame)!)-10, 26, 26)
button.addTarget(self, action: "dismissAnimation", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
    }
    /**
    创建按钮
    */
    private func addAlertButtons(){
        
        for index in 0..<btnTitleArr.count{
            
            if btnTitleArr.count == 2{
                
                let button = UIButton(type: UIButtonType.Custom)
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 4
                button.setTitle(btnTitleArr[index] as? String, forState: UIControlState.Normal)
                button.titleLabel?.font = UIFont.systemFontOfSize(15)
                button.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
                
                let offset = (CGRectGetWidth(bgImageView!.frame)-120*2)/3
                button.frame = CGRectMake(offset*CGFloat(index+1)+120*CGFloat(index), CGRectGetHeight(bgImageView!.frame)-50, 120, 38)
                
                button.tag = index
                
                if index == 0{//拒绝按钮
                    
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).CGColor
                    button.backgroundColor = getColor("F4F3F3")
                    button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
                }
                else{//统一按钮
                    
                    button.backgroundColor = getColor("39C27E")
                    button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                }
                
                bgImageView?.addSubview(button)
            }
        }
    }
    
    // MARK: - 点击按钮回调
    internal func buttonClick(button:UIButton){
        
        if button.tag == 0{
            
            if denyBlock != nil{
                
                denyBlock!()
            }
        }else if button.tag == 1{
            
            if acceptBlock != nil{
                
                acceptBlock!()
            }
        }
        
        self.dismissAnimation()
    }
    
    // MARK: - 动画
    
    internal func performAnimation(){
    
        self.alpha = 0
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.alpha = 1.0
            }, completion: nil)
    }
    
    internal func dismissAnimation(){
        
        self.alpha = 1.0
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.alpha = 0.0
            }, completion: nil)
    }
    
    // MARK: - 展示
    
    func show(){
        
        let alertWindow = UIApplication.sharedApplication().keyWindow
        
        self.addAlertImages()
        self.addAlertLabels()
        self.addAlertButtons()
        self.addCloseBtn()
        
        alertWindow?.addSubview(self)
        self.performAnimation()
    }
}
