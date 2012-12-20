//
//  NCMenu.m
//  NewsCubeMenu
//
//  Created by kadoya on 2012/12/20.
//  Copyright (c) 2012年 Cyclin. All rights reserved.
//

#import "NCMenu.h"
#import "NCMenuItem.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kScrollViewFirstWidth = 12.0f;
static CGFloat const kScrollViewItemMarginWidth = 15.0f;

@implementation NCMenu

#pragma mark -- Initialization Method --
-(id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)bgColor menuItems:(NSArray *)menuItems{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    if (menuItems.count == 0) {
        return nil;
    }
    
    self.backgroundColor = bgColor;
    int menuItemsArrayCount = menuItems.count;
    
    // Setting ScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    NCMenuItem *menuItem = menuItems[0];
    _scrollView.contentSize = CGSizeMake(kScrollViewFirstWidth * 2 + (kScrollViewItemMarginWidth * (menuItemsArrayCount - 1)) + menuItem.image.size.width * menuItemsArrayCount, frame.size.height);
    
    // Do not show scrollIndicator
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView setUserInteractionEnabled:YES];
    [self addSubview:_scrollView];
    
    self.menuArray = menuItems;
    [self setMenu];
    
    return self;
}

-(void)setMenu{
    int i = 0;
    for (NCMenuItem *menuItem in _menuArray) {
        menuItem.tag = 1000 + i;
        //menuItem.startPoint = CGPointMake(menuItem.image.size.width/2 + kScrollViewFirstWidth + kScrollViewItemMarginWidth * i + menuItem.image.size.width * i, self.frame.size.height/2);
        menuItem.center = CGPointMake(menuItem.image.size.width/2 + kScrollViewFirstWidth + kScrollViewItemMarginWidth * i + menuItem.image.size.width * i, self.frame.size.height/2);
        menuItem.delegate = self;
        [_scrollView addSubview:menuItem];
        [self bringSubviewToFront:menuItem];        // NOTE: ちょっと調査を行うこと...
        
        i++;
    }
}

#pragma mark -- NCMenuItem Delegate Method --
-(void)newsCubeMenuItemTouchesBegan:(NCMenuItem *)menuItem{
    menuItem.highlighted = YES;
}

-(void)newsCubeMenuItemTouchesEnd:(NCMenuItem *)menuItem{
    // blowUp animation
    [UIView animateWithDuration:0.4f animations:^{
        CGAffineTransform scaleUpAnimation = CGAffineTransformMakeScale(1.9f, 1.9f);
        menuItem.transform = scaleUpAnimation;
        menuItem.alpha = 0.2;
    } completion:^(BOOL finished) {
        menuItem.transform = CGAffineTransformIdentity;
        menuItem.alpha = 1.0f;
        menuItem.highlighted = NO;
    }];
    
    if ([_delegate respondsToSelector:@selector(newsCubeMenu:didSelectIndex:)]) {
        [_delegate newsCubeMenu:self didSelectIndex:menuItem.tag - 1000];
    }
}

@end
