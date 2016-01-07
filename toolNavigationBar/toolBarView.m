//
//  toolBarView.m
//  toolNavigationBar
//
//  Created by simple on 16/1/6.
//  Copyright © 2016年 levy.com. All rights reserved.
//

#import "toolBarView.h"
#import "Masonry.h"
@interface toolBarView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
@implementation toolBarView

+(toolBarView *)setToolBarViewWithItemArray:(NSArray *)items clickIndex:(clickItemsIndexBlock)clickIndexBolck{
    toolBarView * view = [toolBarView new];
    view.scrollView = [UIScrollView new];
    view.scrollView.delegate = view;
    [view.scrollView setShowsHorizontalScrollIndicator:NO];
    [view setClipsToBounds:NO];
    [view.scrollView setClipsToBounds:NO];
    [view addSubview:view.scrollView];
    [view.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    view.items = items;
    view.block = clickIndexBolck;
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    return view;
}

-(void)setItems:(NSArray *)items{
    _items = items;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    width = (width - 240)*1.0/4.0;
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.text = items.firstObject;
    label.tag = 1000;
    [label setUserInteractionEnabled:YES];
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick:)]];
    [self.scrollView addSubview:label];
    
    CGSize keyWordLabelSize = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil] context:nil].size;
    
    [label setFrame:CGRectMake(0, 0, keyWordLabelSize.width, 44)];
  
    for (int i = 1; i < items.count; i++) {
        UILabel *beforeLabel = [self.scrollView viewWithTag:999+i];
        if (beforeLabel) {
            
            label = [UILabel new];
            label.textColor = [UIColor whiteColor];
            label.text = items.firstObject;
            label.tag = 1000+i;
            [label setUserInteractionEnabled:YES];
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick:)]];
            [self.scrollView addSubview:label];
            
            CGSize keyWordLabelSize = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil] context:nil].size;
            
            [label setFrame:CGRectMake(CGRectGetMaxX(beforeLabel.frame) + width, 0, keyWordLabelSize.width, 44)];
        }
    }
    [self.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(label.frame), 44)];

}

-(void)itemClick:(UITapGestureRecognizer *)tap{
    CGPoint labelPoint = tap.view.center;
    if (self.scrollView.contentSize.width > self.scrollView.frame.size.width) {
        if (labelPoint.x > self.scrollView.center.x && (labelPoint.x - self.scrollView.center.x + self.scrollView.frame.size.width) < self.scrollView.contentSize.width) {
            [self.scrollView setContentOffset:CGPointMake(labelPoint.x - self.scrollView.center.x, 0) animated:YES];
        }else if((labelPoint.x - self.scrollView.center.x + self.scrollView.frame.size.width) > self.scrollView.contentSize.width){
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width -self.scrollView.frame.size.width , 0) animated:YES];
        }else if(labelPoint.x < self.scrollView.center.x){
            [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
        }
    }
    if (self.block) {
        self.block(tap.view.tag - 1000);
    }
}

@end
