NewsCubeMenu
============

![screenshot](https://github.com/kadoya-cyclin/NewsCubeMenu/blob/develop/NewsCubeMenu/ScreenShots/newscubemenu.jpg?raw=true "ScreenShot")
    
NewsCubeMenu can use a variety of function buttons that scroll horizontally.
This Menu can be customized widely!  
- Base image of the button.
- Button's image content.
- The number of buttons...  

Everyone can be customized the way you want this menu is possible!  
For example, here's how easy it is create NewsCubeMenu!
```objectivec
    NSMutableArray *menus = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        NCMenuItem *menuItem = [[NCMenuItem alloc] initWithImage:nc_button_baseImage highlightedImage:nc_button_highlightedBaseImage ContentImage:nc_contentImage highlightedContentImage:nc_contentImage];
        [menus addObject:menuItem];
    }

    _newsCubeMenu = [[NCMenu alloc] initWithFrame:newsCubeMenuPos withBackgroundColor:[UIColor clearColor] menuItems:menus];
    [_newsCubeMenu setDelegate:self];
```
Please try to see the following sentence has a variety of functions more.

How To Get Started
---------------------
+ Download NewsCubeMenu and try out the included iPhone example app.
+ Read this Document to check the APIs available in NewsCubeMenu.

How To Include It
---------------------
+ Copy NCMenuItem.hm and NCMenu.hm file in NewsCubeMenu folder.
+ Add QuartzCore.framework to your project's Link Binary With Libraries build phase.


Example Usage
----------------
####Create NCMenuItem
````objectivec
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
````

####Add NCMenuItem to NCMenu and Display Menu.
````objectivec
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect newsCubeMenuPos = CGRectMake(0,applicationFrame.size.height, applicationFrame.size.width, 70);
    _newsCubeMenu = [[NCMenu alloc] initWithFrame:newsCubeMenuPos withBackgroundColor:[UIColor clearColor] menuItems:menus];
    [_newsCubeMenu setDelegate:self];
    [_webView addSubview:_newsCubeMenu];
````

####popUpMenuFunction
````objectivec
-(void)popUpNewsCubeMenu{
    NSLog(@"%s",__func__);
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = _newsCubeMenu.frame;
        frame.origin.y -= frame.size.height;
        _newsCubeMenu.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}
````

####Callback methods when the button was pressed.
+ You are convenient to use an enumerated type.  

````objectivec
-(void)newsCubeMenu:(NCMenu *)menu didSelectIndex:(NSInteger)selectedIndex{
    NSLog(@"%s:SelectedIndex:%d",__func__,selectedIndex);
}
````

Credits
-----------
NewsCubeMenu was created by Shota Kondou([@cyclin_devel](https://twitter.com/cyclin_devel)) in development of [NewsCube](https://itunes.apple.com/jp/app/hua-tinonyusuwoo-jieke-newscube/id583726443?mt=8).

License
----------
NewsCubeMenu is available under the MIT license. See the LICENSE file for more info.
