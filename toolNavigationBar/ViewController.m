//
//  ViewController.m
//  toolNavigationBar
//
//  Created by simple on 16/1/6.
//  Copyright © 2016年 levy.com. All rights reserved.
//

#import "ViewController.h"
#import "toolBarView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    toolBarView *view = [toolBarView setToolBarViewWithItemArray:@[@"title",@"title",@"title",@"title",@"title",@"title",@"title"] clickIndex:^(NSInteger index) {
        NSLog(@"%ld",index);
    }];
    
    [self.navigationItem setTitleView:view];

    
    //设者导航栏的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
//    self.navigationControlle = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
