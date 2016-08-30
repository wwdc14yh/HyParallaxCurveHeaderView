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
将下载好的项目提取以下类托入项目中
`UIImage+ImageEffects.h/.m`
`HyParallaxCurveHeaderView.h/.m`
将`HyParallaxCurveHeaderView.h`import

### Podfile
使用`Podfile`进行代码集成，详情看下面

打开`Podfile`添加以下代码

`pod 'HyParallaxCurveHeaderView', :git => 'https://github.com/wwdc14/HyParallaxCurveHeaderView.git'`保存->`pod install`

###使用方法

实例`HyParallaxCurveHeaderView`
```obj
HyParallaxCurveHeaderView *curveHeaderView = [HyParallaxCurveHeaderView loadHeaderCurveViewWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 300)];
_tableView.tableHeaderView = curveHeaderView;
```

###属性以及方法说明
* 属性

`@property (nonatomic) CGFloat curveFloat` 曲线弧度取值范围0.0~1.0

`@property (nonatomic) BOOL suggestCurve`  是否设置推荐弧度(为YES"curveFloat"属性失效)

`@property (nonatomic, strong, nonnull) UIColor *curveColor` 曲面颜色

`@property (nonatomic, strong, nonnull) UIColor *backgroundColor` 背景颜色

`@property (nonatomic) CGFloat imageWidth` imageView宽度

`@property (nonatomic, nonnull, strong, readonly) UIView *followBottomView` 跟随底部View

`@property (nonatomic, nonnull, strong, readonly) UIImageView *imageView` imageView

`@property (nonatomic, strong, nonnull) UIColor *blurTintColor` 模糊颜色

`@property (assign, nonatomic) BOOL isShowBlur` 是否显示模糊

`@property (assign, nonatomic) BOOL isParallax` 是否具有视差效果

* 函数

`- (void) layoutHeaderViewForScrollViewOffset:(CGPoint)offset` 实现下拉改变曲面重要方法(必须调用)

`+ (_Nonnull instancetype)loadHeaderCurveViewWithSize:(CGSize)size` 初始化方法

### 注意事项

* 非常感谢[Vinodh-G](https://github.com/Vinodh-G/ParallaxTableViewHeader)开源的`ParallaxTableViewHeader`三方库提供滑动视差效果. 

### 期待
* 如果在使用过程中遇到BUG，希望你能Issues我
* 如果觉得好用请Star!

