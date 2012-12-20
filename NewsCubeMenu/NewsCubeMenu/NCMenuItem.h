//
//  NCMenuItem.h
//  NewsCubeMenu
//
//  Created by kadoya on 2012/12/20.
//  Copyright (c) 2012年 Cyclin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NCMenuItemDelegate;

@interface NCMenuItem : UIImageView

@property(nonatomic) CGPoint startPoint;
@property(nonatomic, strong) UIImageView *contentImageView;

@property(nonatomic, weak) id <NCMenuItemDelegate> delegate;

// Create MenuItem
-(id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)hImage ContentImage:(UIImage *)cImage highlightedContentImage:(UIImage *)hcImage;

@end

@protocol NCMenuItemDelegate <NSObject>
-(void)newsCubeMenuItemTouchesBegan:(NCMenuItem *)menuItem;
-(void)newsCubeMenuItemTouchesEnd:(NCMenuItem *)menuItem;
@end