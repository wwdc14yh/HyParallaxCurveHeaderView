//
//  HyParallaxCurveHeaderView.m
//  TableViewCurveHeaderView
//
//  Created by Hy_Mac on 16/8/29.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HyParallaxCurveHeaderView.h"
#import "UIImage+ImageEffects.h"

@interface HyHeaderCurveView : UIView
@property (nonatomic) CGFloat POINT_Y1;
@property (nonatomic) BOOL suggestCurve;
@property (nonatomic) CGFloat imageWidth;
@property (nonatomic) CGFloat curveFloat;
@property (nonatomic, strong, nonnull) UIColor *curveColor;
@property (nonatomic, strong, nonnull) UIColor *backgroundColor;
@property (nonatomic, nonnull, strong, readonly) UIView *followBottomView;
@property (nonatomic, nonnull, strong, readonly) UIImageView *imageView;
@property (nonnull, nonatomic, strong) UIBezierPath* rectanglePath;
@property (nonnull, nonatomic, strong) UIBezierPath* bezierPath;
@property (nonnull, nonatomic, strong) CAShapeLayer* shapeLayer;
@end

#define w [UIScreen mainScreen].bounds.size.width
#define MAX_Y CGRectGetMaxY(self.frame)
#define MARGIN 70

@implementation HyHeaderCurveView

- (instancetype) init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    
    _bezierPath = [UIBezierPath bezierPath];
    {
        _shapeLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_shapeLayer];
        _shapeLayer.frame = self.frame;
    }
    _bezierPath = [UIBezierPath bezierPath];
    _curveFloat = 0.48f;
    _POINT_Y1 = 0.0f;
    _suggestCurve = false;
    {
        _followBottomView = [self viewWithTag:1000];
        if (!_followBottomView) {
            _followBottomView = [UIView new];
            [self addSubview:_followBottomView];
            _followBottomView.tag = 1000;
        }
    }
    
    {
        _imageWidth = 60;
        _imageView = [[UIImageView alloc] init];
        _imageView.tag = 1001;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        _imageView.layer.masksToBounds = true;
        _imageView.layer.borderWidth = 2.f;
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageView.layer.cornerRadius = _imageWidth/2;
    }
}

- (void)setImageWidth:(CGFloat)imageWidth
{
    _imageWidth = imageWidth;
    _imageView.layer.cornerRadius = _imageWidth/2;
    _imageView.frame = CGRectMake(_imageView.frame.origin.x,
                                  _imageView.frame.origin.y,
                                  _imageWidth,
                                  _imageWidth);
}

- (void)setCurveColor:(UIColor *)curveColor
{
    _curveColor = curveColor;
    _shapeLayer.fillColor = _curveColor.CGColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    _shapeLayer.backgroundColor = _backgroundColor.CGColor;
}

- (void) setPOINT_Y1:(CGFloat)POINT_Y1
{
    //_POINT_Y1 = POINT_Y1;
    _POINT_Y1 = POINT_Y1 * CGRectGetHeight(self.frame);
    _followBottomView.frame = CGRectMake(0,
                                         _POINT_Y1,
                                         CGRectGetWidth(self.frame),
                                         CGRectGetHeight(self.frame) - _POINT_Y1);
    [self setNeedsDisplay];
}

- (void)setSuggestCurve:(BOOL)suggestCurve
{
    _suggestCurve = suggestCurve;
    if (_suggestCurve) {
        [self setPOINT_Y1:(CGRectGetMidY(self.frame)/2)/CGRectGetMidY(self.frame)];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _shapeLayer.frame = frame;
    [self setNeedsDisplay];
    if (_POINT_Y1 == 0.0f) {
        
        _POINT_Y1 = CGRectGetMidY(frame);
        _followBottomView.frame = CGRectMake(0,
                                             _POINT_Y1,
                                             CGRectGetWidth(self.frame),
                                             CGRectGetHeight(self.frame) - CGRectGetMaxY(_imageView.frame));
    }
    [_followBottomView setFrame:CGRectMake(0,
                                           CGRectGetMaxY(self.frame) - CGRectGetHeight(_followBottomView.frame),
                                           w,
                                           CGRectGetHeight(_followBottomView.frame))];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat progress = CGRectGetHeight(rect)/CGRectGetHeight([UIScreen mainScreen].bounds);
    progress = MAX(progress - 0.3, 0.0f);
    CGFloat centerX = CGRectGetMidX(self.frame);
    CGFloat point6X = CGRectGetMaxX(self.frame)-MARGIN;
    CGFloat dragY   = ((_curveFloat * CGRectGetHeight(self.frame)) - (progress*400)) + (progress*400);//速度差值
    if (_suggestCurve) {
        dragY   = (_POINT_Y1 - 85) + (progress*400);
    }
    
    {
        _imageView.frame = CGRectMake(centerX - _imageWidth/2,
                                      dragY - _imageWidth/2,
                                      _imageWidth,
                                      _imageWidth);
    }
    
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(0, _POINT_Y1)],    //point0
                        [NSValue valueWithCGPoint:CGPointMake(0, MAX_Y)],        //point1
                        [NSValue valueWithCGPoint:CGPointMake(w, MAX_Y)],        //point2
                        [NSValue valueWithCGPoint:CGPointMake(w, _POINT_Y1)],    //point3
                        [NSValue valueWithCGPoint:CGPointMake(centerX, dragY)],  //point4
                        [NSValue valueWithCGPoint:CGPointMake(w, _POINT_Y1)],    //point5
                        [NSValue valueWithCGPoint:CGPointMake(point6X, dragY)],  //point6
                        [NSValue valueWithCGPoint:CGPointMake(0, _POINT_Y1)],    //point7
                        [NSValue valueWithCGPoint:CGPointMake(MARGIN, dragY)],   //point8
                        [NSValue valueWithCGPoint:CGPointMake(0, _POINT_Y1)]     //point9
                        ];
    //标记关键点
    //    for (NSValue * value in points) {
    //        NSInteger index = [points indexOfObject:value];
    //        CGPoint point = [value CGPointValue];
    //        UILabel *view = [self viewWithTag:index+100];
    //        if (!view) {
    //            view = [[UILabel alloc] init];
    //            view.tag = index+100;
    //            [self addSubview:view];
    //            view.backgroundColor = [UIColor redColor];
    //            view.textAlignment = 1;
    //            view.clipsToBounds = true;
    //        }
    //        view.text = [NSString stringWithFormat:@"%zd",index];
    //        [view setFrame:CGRectMake(point.x-10/2, point.y-5/2, 10, 10)];
    //        view.layer.cornerRadius = 10/2;
    //        view.font = [UIFont systemFontOfSize:10];
    //        view.textColor = [UIColor whiteColor];
    //        view.hidden = true;
    //    }
    
    // Bezier Drawing
    [_bezierPath removeAllPoints];
    [_bezierPath moveToPoint: [[points objectAtIndex:0] CGPointValue]];
    [_bezierPath addLineToPoint: [[points objectAtIndex:1] CGPointValue]];
    [_bezierPath addLineToPoint: [[points objectAtIndex:2] CGPointValue]];
    [_bezierPath addLineToPoint: [[points objectAtIndex:3] CGPointValue]];
    
    [_bezierPath addCurveToPoint: [[points objectAtIndex:4] CGPointValue]
                   controlPoint1: [[points objectAtIndex:5] CGPointValue]
                   controlPoint2: [[points objectAtIndex:6] CGPointValue]];
    
    [_bezierPath addCurveToPoint: [[points objectAtIndex:7] CGPointValue]
                   controlPoint1: [[points objectAtIndex:8] CGPointValue]
                   controlPoint2: [[points objectAtIndex:9] CGPointValue]];
    _shapeLayer.path = _bezierPath.CGPath;
    points = nil;
}

@end

@interface HyParallaxCurveHeaderView ()
@property (weak, nonatomic)  UIScrollView *scrollView;
@property (weak, nonatomic)  HyHeaderCurveView *subView;
@property (nonatomic)        UIImageView *bluredImageView;
@property (nonnull, strong, nonatomic) HyHeaderCurveView *curveView;
@end

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
static CGFloat kParallaxDeltaFactor = 0.5f;

@implementation HyParallaxCurveHeaderView

+ (_Nonnull instancetype)loadHeaderCurveViewWithSize:(CGSize)size
{
    HyParallaxCurveHeaderView *headerView = [[HyParallaxCurveHeaderView alloc] initWithFrame:(CGRect){CGPointZero,size}];
    HyHeaderCurveView *curveView = [[HyHeaderCurveView alloc] initWithFrame:headerView.frame];
    headerView.isShowBlur = true;
    headerView.isParallax = true;
    [headerView initialSetupForCustomSubView:curveView];
    return headerView;
}

- (void)initialSetupForCustomSubView:(HyHeaderCurveView *)subView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView = scrollView;
    self.subView = subView;
    _followBottomView = _subView.followBottomView;
    _imageView = _subView.imageView;
    subView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.scrollView addSubview:subView];
    
    self.bluredImageView = [[UIImageView alloc] initWithFrame:subView.frame];
    self.bluredImageView.autoresizingMask = subView.autoresizingMask;
    self.bluredImageView.alpha = 0.0f;
    [self.scrollView addSubview:self.bluredImageView];
    
    [self addSubview:self.scrollView];
    if (_isShowBlur) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self refreshBlurView];
        });
    }
}

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
    CGRect frame = self.scrollView.frame;
    if (offset.y > 0)
    {
        if (_isParallax) {
            frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0);
        }
        self.scrollView.frame = frame;
        self.bluredImageView.alpha =   1 / kDefaultHeaderFrame.size.height * offset.y * 2;
        self.clipsToBounds = YES;
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.scrollView.frame = rect;
        self.clipsToBounds = NO;
        self.bluredImageView.alpha = offset.y/kDefaultHeaderFrame.size.height;
    }
}

- (void)refreshBlurView
{
    UIImage *screenShot = [self screenShotOfView:self];
    
    UIColor *color = _blurTintColor;
    if (!color) {
        color = [UIColor colorWithWhite:0.3 alpha:0.4];
    }
    
    screenShot = [screenShot applyBlurWithRadius:6 tintColor:color saturationDeltaFactor:1.0 maskImage:nil];
    self.bluredImageView.image = screenShot;
}

- (UIImage *)screenShotOfView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(kDefaultHeaderFrame.size, YES, 0.0);
    [self drawViewHierarchyInRect:kDefaultHeaderFrame afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setCurveColor:(UIColor *)curveColor
{
    _curveColor = curveColor;
    _subView.curveColor = curveColor;
}

- (void)setSuggestCurve:(BOOL)suggestCurve
{
    _suggestCurve = suggestCurve;
    _subView.suggestCurve = suggestCurve;
}

- (void)setCurveFloat:(CGFloat)curveFloat
{
    _curveFloat = curveFloat;
    _subView.curveFloat = curveFloat;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    _subView.backgroundColor = backgroundColor;
}

- (void)setPOINT_Y1:(CGFloat)POINT_Y1
{
    _POINT_Y1 = POINT_Y1;
    _subView.POINT_Y1 = POINT_Y1;
}

- (void)setImageWidth:(CGFloat)imageWidth
{
    _imageWidth = imageWidth;
    _subView.imageWidth = imageWidth;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
