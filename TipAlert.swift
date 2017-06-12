//
//  TipAlert.swift
//  TipAlert-SwiftDemo
//
//  Created by 吕俊 on 15/9/30.
//  Copyright © 2015年 Akring. All rights reserved.
//

import UIKit

// MARK: - 转换RGB颜色
func getColor(_ hexColor:NSString) ->UIColor{
    
    var redInt:UInt32 = 0
    var greenInt:UInt32 = 0
    var blueInt:UInt32 = 0
    var rangeNSRange:NSRange! = NSMakeRange(0, 0)
    rangeNSRange.length = 2
    
    //取红色值
    rangeNSRange.location = 0
    Scanner(string: hexColor.substring(with: rangeNSRange)).scanHexInt32(&redInt)
    
    //取绿色值
    rangeNSRange.location = 2
    Scanner(string: hexColor.substring(with: rangeNSRange)).scanHexInt32(&greenInt)
    
    //取蓝色值
    rangeNSRange.location = 4
    Scanner(string: hexColor.substring(with: rangeNSRange)).scanHexInt32(&blueInt)
    
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
    
    fileprivate var bgImageView:UIImageView? = nil
    fileprivate var contextLabel:UILabel? = nil
    fileprivate var alertSize:CGSize? = nil
    
    // MARK: - 初始化方法
    
    init(message:String,image:UIImage,buttonArray:NSArray){
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+20)
        
        btnTitleArr = buttonArray
        topImage = image
        contextStr = message
        alertSize = CGSize(width: rect.size.width-60, height: rect.size.width-60)
        alignment = NSTextAlignment.center
        
        super.init(frame: rect)
        
        let bgView = UIView(frame: rect)
        bgView.backgroundColor = UIColor.black
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
    fileprivate func addAlertImages(){
        
        let bgRect = CGRect(x: 0, y: 0, width: (alertSize?.width)!, height: (alertSize?.height)!)
        
        bgImageView = UIImageView()
        bgImageView!.backgroundColor = UIColor.white
        bgImageView!.frame = bgRect
        bgImageView!.isUserInteractionEnabled = true
        bgImageView!.layer.masksToBounds = true
        bgImageView!.layer.cornerRadius = 10
        bgImageView!.layer.borderColor = UIColor(white: 0.147, alpha: 1).cgColor
        bgImageView!.layer.borderWidth = 1;
        self.addSubview(bgImageView!)
        
        let imageRect = CGRect(x: 0, y: 0, width: (alertSize?.width)!, height: (alertSize?.width)!/2)
        let topImageView = UIImageView()
        topImageView.image = topImage
        topImageView.backgroundColor = UIColor.white
        topImageView.frame = imageRect
        bgImageView?.addSubview(topImageView)
    }
    /**
    创建文字Label
    */
    fileprivate func addAlertLabels(){
        
        let width = (alertSize?.width)!-60
        
        let rect = CGRect(x: ((bgImageView?.frame)!.width-width)/2, y: (alertSize?.width)!/2.2, width: width, height: (alertSize?.width)!/3)
        
        contextLabel = UILabel(frame: rect)
        contextLabel!.backgroundColor = UIColor.clear
        contextLabel!.textAlignment = alignment
        contextLabel!.textColor = UIColor.black
        contextLabel!.font = UIFont.systemFont(ofSize: 15)
        contextLabel!.numberOfLines = 3
        contextLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        contextLabel!.text = contextStr
        
        bgImageView?.addSubview(contextLabel!)
        bgImageView?.center = self.center
    }
    /**
    创建关闭按钮
    */
    fileprivate func addCloseBtn(){
        
        let button = CloseButton(type: UIButtonType.system)
        button.frame = CGRect(x: (bgImageView?.frame)!.maxX-18, y: (bgImageView?.frame)!.minY-10, width: 26, height: 26)
button.addTarget(self, action: #selector(TipAlert.dismissAnimation), for: UIControlEvents.touchUpInside)
        self.addSubview(button)
    }
    /**
    创建按钮
    */
    fileprivate func addAlertButtons(){
        
        for index in 0..<btnTitleArr.count{
            
            if btnTitleArr.count == 2{
                
                let button = UIButton(type: UIButtonType.custom)
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 4
                button.setTitle(btnTitleArr[index] as? String, for: UIControlState())
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.addTarget(self, action: #selector(TipAlert.buttonClick(_:)), for: UIControlEvents.touchUpInside)
                
                let offset = (bgImageView!.frame.width-120*2)/3
                button.frame = CGRect(x: offset*CGFloat(index+1)+120*CGFloat(index), y: bgImageView!.frame.height-50, width: 120, height: 38)
                
                button.tag = index
                
                if index == 0{//拒绝按钮
                    
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).cgColor
                    button.backgroundColor = getColor("F4F3F3")
                    button.setTitleColor(UIColor.darkGray, for: UIControlState())
                }
                else{//统一按钮
                    
                    button.backgroundColor = getColor("39C27E")
                    button.setTitleColor(UIColor.white, for: UIControlState())
                }
                
                bgImageView?.addSubview(button)
            }
        }
    }
    
    // MARK: - 点击按钮回调
    internal func buttonClick(_ button:UIButton){
        
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
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.alpha = 1.0
            }, completion: nil)
    }
    
    internal func dismissAnimation(){
        
        self.alpha = 1.0
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.alpha = 0.0
            }, completion: nil)
    }
    
    // MARK: - 展示
    
    func show(){
        
        let alertWindow = UIApplication.shared.keyWindow
        
        self.addAlertImages()
        self.addAlertLabels()
        self.addAlertButtons()
        self.addCloseBtn()
        
        alertWindow?.addSubview(self)
        self.performAnimation()
    }
}
