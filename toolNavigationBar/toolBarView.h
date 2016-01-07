//
//  toolBarView.h
//  toolNavigationBar
//
//  Created by simple on 16/1/6.
//  Copyright © 2016年 levy.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickItemsIndexBlock)(NSInteger index);
@interface toolBarView : UIView
@property (copy,nonatomic) clickItemsIndexBlock block;
+(toolBarView *)setToolBarViewWithItemArray:(NSArray *)items clickIndex:(clickItemsIndexBlock)clickIndexBolck;
@end
