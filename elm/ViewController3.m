//
//  ViewController3.m
//  elm
//
//  Created by Usher Man on 2017/8/8.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "ViewController3.h"
#import "UIScrollView+USRefreshView.h"
#import "UIView+Layout.h"

@interface ViewController3 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"RefreshAnimation";
    
    [self.tableView addRefreshHeaderWithHandle:^{
        NSLog(@"开始刷新");
    }];
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height -64 ) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor purpleColor];
        _tableView.tableFooterView= [UIView new];
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
//    cell.hidden=YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:0.0277 green:0.7235 blue:0.5135 alpha:1.0];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"结束刷新");
    [tableView.header stopAnimation];
}

@end
