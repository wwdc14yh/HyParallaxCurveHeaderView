//
//  HyParallaxCurveHeaderView.h
//  TableViewCurveHeaderView
//
//  Created by Hy_Mac on 16/8/29.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HyParallaxCurveHeaderView : UIView


/**
 *  弧度;
 默认 0.7f;
 取值范围(0.0f ~ 1.0f)
 */
@property (nonatomic) CGFloat curveFloat;

/**
 *  是否设置推荐弧度(为YES"curveFloat"属性失效)
 默认 NO
 取值范围(YES ~ NO)
 */
@property (nonatomic) BOOL suggestCurve;

/**
 *  曲面颜色
 */
@property (nonatomic, strong, nonnull) UIColor *curveColor;

/**
 *  背景颜色
 */
@property (nonatomic, strong, nonnull) UIColor *backgroundColor;

/**
 *  ...
 */
@property (nonatomic) CGFloat POINT_Y1;

@property (nonatomic) CGFloat imageWidth;

@property (nonatomic, nonnull, strong, readonly) UIView *followBottomView;

@property (nonatomic, nonnull, strong, readonly) UIImageView *imageView;

@property (nonatomic, strong, nonnull) UIColor *blurTintColor;

@property (assign, nonatomic) BOOL isShowBlur;

@property (assign, nonatomic) BOOL isParallax;

- (void) layoutHeaderViewForScrollViewOffset:(CGPoint)offset;

+ (_Nonnull instancetype)loadHeaderCurveViewWithSize:(CGSize)size;

@end
