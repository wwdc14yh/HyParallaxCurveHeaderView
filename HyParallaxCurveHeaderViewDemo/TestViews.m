//
//  TestViews.m
//  TableViewCurveHeaderView
//
//  Created by Hy_Mac on 16/8/26.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "TestViews.h"

@interface TestViews ()
@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end

@implementation TestViews

- (void)awakeFromNib
{
    [super awakeFromNib];
    _button0.layer.cornerRadius = 15.f;
    _button0.layer.borderColor = [UIColor colorWithRed:62.f/255.f green:177.f/255.f blue:251.f/255.f alpha:1].CGColor;
    _button0.layer.borderWidth = 1.f/2.f;
    
    _button1.layer.cornerRadius = 15.f;
    _button1.layer.borderColor = [UIColor colorWithRed:62.f/255.f green:177.f/255.f blue:251.f/255.f alpha:1].CGColor;
    _button1.layer.borderWidth = 1.f/2.f;
    
    _button2.layer.cornerRadius = 15.f;
    _button2.layer.borderColor = [UIColor colorWithRed:252.f/255.f green:183.f/255.f blue:66.f/255.f alpha:1].CGColor;
    _button2.layer.borderWidth = 1.f;
    
}

+ (_Nonnull instancetype)loadXib
{
    // Instantiate the nib content without any reference to it.
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"TestViews" owner:nil options:nil];
    
    // Find the view among nib contents (not too hard assuming there is only one view in it).
    return [nibContents lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
