//
// NCMenu.m
// NewsCubeMenu
//
// Copyright (c) 2012 Shota Kondou, Cyclin. and FOU.Inc.
// http://cyclin.jp
// http://fou.co.jp
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
        menuItem.center = CGPointMake(menuItem.image.size.width/2 + kScrollViewFirstWidth + kScrollViewItemMarginWidth * i + menuItem.image.size.width * i, self.frame.size.height/2);
        menuItem.delegate = self;
        [_scrollView addSubview:menuItem];
        
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
