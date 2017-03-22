//
//  ViewController.swift
//  TipAlert-SwiftDemo
//
//  Created by 吕俊 on 15/9/30.
//  Copyright © 2015年 Akring. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var alert:TipAlert!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alert = TipAlert(message: "卖萌求鼓励\nXXX新版本用着还喜欢么，给点鼓励好不好呢？", image: UIImage(named: "exampleImage")!, buttonArray: ["反馈问题","鼓励我们"])
        
        alert.acceptBlock = {
            
            print("去评价了！")
        }
        alert.denyBlock = {
            
            print("其实我是拒绝的")
        }}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    弹出提示窗
    
    - parameter sender:
    */
    @IBAction func showAlert(_ sender: AnyObject) {
        
        alert.show()
    }
    

}

