![Swift3](https://img.shields.io/badge/Swift%203-Yes-brightgreen.svg)
[![GitHub issues](https://img.shields.io/github/issues/akring/TipAlert-SwiftDemo.svg)](https://github.com/akring/TipAlert-SwiftDemo/issues)
[![Magnum CI](https://img.shields.io/magnumci/ci/96ffb83fa700f069024921b0702e76ff.svg)]()
# TipAlert-SwiftDemo
高仿QQ音乐提示评论Alert的Swift版

# 效果
![效果](http://7te7sy.com1.z0.glb.clouddn.com/TipAlert.png)

# 安装

将`TipAlert`文件夹拖入项目即可

# 使用

API部分和系统自带的UIAlertView类似，点击按钮的回调使用了Block的方式实现。


* 创建Alert并展示：

```
alert = TipAlert(message: "卖萌求鼓励\nXXX新版本用着还喜欢么，给点鼓励好不好呢？", image: UIImage(named: "exampleImage")!, buttonArray: ["反馈问题","鼓励我们"])
        
        alert.acceptBlock = {
            
            print("去评价了！")
        }
        alert.denyBlock = {
            
            print("其实我是拒绝的!")
        }}
```

* 需要弹出Alert的时候调用

```
@IBAction func showAlert(sender: AnyObject) {
        
        alert.show()
    }
```


