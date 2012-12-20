//
//  NCMenu.h
//  NewsCubeMenu
//
//  Created by kadoya on 2012/12/20.
//  Copyright (c) 2012年 Cyclin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCMenuItem.h"

@protocol NCMenuDelegate;

@interface NCMenu : UIView<NCMenuItemDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) NSArray *menuArray;
@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, weak) id <NCMenuDelegate> delegate;

// Create MenuBase
-(id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)bgColor menuItems:(NSArray *)menuItems;
@end

@protocol NCMenuDelegate <NSObject>
-(void)newsCubeMenu:(NCMenu *)menu didSelectIndex:(NSInteger)selectedIndex;
@end
