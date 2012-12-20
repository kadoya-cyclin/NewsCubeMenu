//
//  NCSampleProjViewController.m
//  NewsCubeMenu
//
//  Created by kadoya on 2012/12/20.
//  Copyright (c) 2012年 Cyclin. All rights reserved.
//

#import "NCSampleProjViewController.h"
#import "NCMenu.h"
#import "NCMenuItem.h"

@interface NCSampleProjViewController ()

@end

@implementation NCSampleProjViewController

#pragma mark -- Initialization Code --
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark -- Views LifeCycle --
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Setup WebView
    [self setUpWebView];
    
    // Setup NewsCubeMenu
    [self setUpNewsCubeMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- Settings --
-(void)setUpWebView{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    CGRect webViewFrame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height - statusBarFrame.size.height);
    _webView = [[UIWebView alloc] initWithFrame:webViewFrame];
    [_webView setDelegate:self];
    [self.view addSubview:_webView];
    
    [self loadingTestGoogle];
}

-(void)setUpNewsCubeMenu{
    // Create NCMenuItem
    // Base Image
    UIImage *nc_button_baseImage = [UIImage imageNamed:@"nc_button_baseImage.png"];
    UIImage *nc_button_highlightedBaseImage = [UIImage imageNamed:@"nc_button_highlightedImage.png"];
    
    // ContentImage
    UIImage *nc_contentImage = [UIImage imageNamed:@"nc_contentImage.png"];
    
    NSMutableArray *menus = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        NCMenuItem *menuItem = [[NCMenuItem alloc] initWithImage:nc_button_baseImage highlightedImage:nc_button_highlightedBaseImage ContentImage:nc_contentImage highlightedContentImage:nc_contentImage];
        [menus addObject:menuItem];
    }
    
    // Create NCMenu
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    CGRect newsCubeMenuPos = CGRectMake(0, windowFrame.size.height, windowFrame.size.width, 55);
    _newsCubeMenu = [[NCMenu alloc] initWithFrame:newsCubeMenuPos withBackgroundColor:[UIColor redColor] menuItems:menus];
    [_webView addSubview:_newsCubeMenu];
    
    
    // PopUpMenus
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self popUpNewsCubeMenu];
    });
    
}

-(void)popUpNewsCubeMenu{
    NSLog(@"%s",__func__);
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = _newsCubeMenu.frame;
//        frame.origin.y -= _newsCubeMenu.frame.size.height;
        frame.origin.y -= 100;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)loadingTestGoogle{
    NSURLRequest *googleTopRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.google.com"]];
    [_webView loadRequest:googleTopRequest];
}


#pragma mark -- UIWebViewDelegate Methods --
-(void)webViewDidStartLoad:(UIWebView *)webView{
    // Show Indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    // Stop Indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

@end
