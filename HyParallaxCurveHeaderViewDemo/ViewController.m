//
//  ViewController.m
//  HyParallaxCurveHeaderViewDemo
//
//  Created by Hy_Mac on 16/8/29.
//  Copyright © 2016年 @Hy. All rights reserved.
//

#import "TestViews.h"
#import "ViewController.h"
#import "HyParallaxCurveHeaderView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nullable, nonatomic, assign)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    {
        UITableView *tableView = [UITableView new];
        _tableView = tableView;
        _tableView.frame = [UIScreen mainScreen].bounds;
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        HyParallaxCurveHeaderView *curveHeaderView = [HyParallaxCurveHeaderView loadHeaderCurveViewWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 300)];
        curveHeaderView.imageView.image = [UIImage imageNamed:@"11381801"];
        curveHeaderView.curveFloat = 140.f/300.f;
        curveHeaderView.POINT_Y1 = 160.f/300.f;
        curveHeaderView.suggestCurve = false;
        curveHeaderView.curveColor = [UIColor whiteColor];
        curveHeaderView.backgroundColor = [UIColor colorWithRed:69.f/255.f green:168.f/255.f blue:244.f/255.f alpha:1];
        curveHeaderView.blurTintColor = [UIColor colorWithRed:69.f/255.f green:168.f/255.f blue:244.f/255.f alpha:0.2f];
        
        TestViews *views = [TestViews loadXib];
        views.backgroundColor = [UIColor clearColor];
        views.frame = CGRectMake(0, 0, CGRectGetWidth(curveHeaderView.followBottomView.frame), CGRectGetHeight(curveHeaderView.followBottomView.frame));
        [curveHeaderView.followBottomView addSubview:views];
        _tableView.tableHeaderView = curveHeaderView;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return  cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [(HyParallaxCurveHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
