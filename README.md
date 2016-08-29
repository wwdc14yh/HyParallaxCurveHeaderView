---
#HyParallaxCurveHeaderView
-------------
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
             )](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-ObjC-brightgreen.svg?style=flat)](https://developer.apple.com/Objective-C)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
> 关于**HyParallaxCurveHeaderView**灵感来自于[智联招聘App]()

####示例:  

![image](https://github.com/wwdc14/HyParallaxCurveHeaderViewDemo/blob/master/HyParallaxCurveHeaderViewDemo/preview.gif)

###原理说明
1.采用贝塞尔曲线绘制曲线视图具体看`- (void)drawRect:(CGRect)rect`方法


### 下载安装
    将下载好的`UIImage+ImageEffects.h/.m`
            `HyParallaxCurveHeaderView.h/.m`
    拖进项目

###使用方法
    实例`HyParallaxCurveHeaderView`
    ```obj
        
    HyParallaxCurveHeaderView *curveHeaderView = [HyParallaxCurveHeaderView loadHeaderCurveViewWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 300)];

    ```

###属性以及方法说明

### 注意事项
开源库需要[Facebook](https://github.com/facebook)开源的动画框架-[Pop](https://github.com/facebook/pop)支持。

### 期待
* 如果在使用过程中遇到BUG，希望你能Issues我
* 如果觉得好用请Star!
* 企鹅号：九六四零六九六二七 😄

