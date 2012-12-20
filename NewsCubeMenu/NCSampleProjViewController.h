//
//  NCSampleProjViewController.h
//  NewsCubeMenu
//
//  Created by kadoya on 2012/12/20.
//  Copyright (c) 2012年 Cyclin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCMenu.h"

@interface NCSampleProjViewController : UIViewController<UIWebViewDelegate, NCMenuDelegate>

@property(nonatomic, strong) UIWebView *webView;

// NCMenu
@property(nonatomic, strong) NCMenu *newsCubeMenu;

@end
