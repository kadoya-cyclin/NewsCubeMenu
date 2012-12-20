//
// NCSampleProjViewController.m
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
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect webViewFrame = CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height);
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
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect newsCubeMenuPos = CGRectMake(0,applicationFrame.size.height, applicationFrame.size.width, 70);
    _newsCubeMenu = [[NCMenu alloc] initWithFrame:newsCubeMenuPos withBackgroundColor:[UIColor clearColor] menuItems:menus];
    [_newsCubeMenu setDelegate:self];
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
        frame.origin.y -= frame.size.height;
        _newsCubeMenu.frame = frame;
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


#pragma mark -- NCMenu Delegate Method --
-(void)newsCubeMenu:(NCMenu *)menu didSelectIndex:(NSInteger)selectedIndex{
    NSLog(@"%s:SelectedIndex:%d",__func__,selectedIndex);
}

@end
