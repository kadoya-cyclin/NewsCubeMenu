//
//  NCMenuItem.m
//  NewsCubeMenu
//
//  Created by kadoya on 2012/12/20.
//  Copyright (c) 2012年 Cyclin. All rights reserved.
//

#import "NCMenuItem.h"

static inline CGRect ScaleRect(CGRect rect, float n){
    return CGRectMake((rect.size.width - rect.size.width * n)/2, (rect.size.height - rect.size.height * n)/2, rect.size.width * n, rect.size.height * n);
}

@implementation NCMenuItem

#pragma mark -- Initialization And CreanUp --
-(id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)hImage ContentImage:(UIImage *)cImage highlightedContentImage:(UIImage *)hcImage{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // Initialization Code Here...
    self.image = image;
    self.highlightedImage = hImage;
    self.userInteractionEnabled = YES;
    _contentImageView = [[UIImageView alloc] initWithImage:cImage];
    _contentImageView.highlightedImage = hcImage;
    [self addSubview:_contentImageView];
    
    return self;
}

#pragma mark -- UIView's Method --
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.bounds = CGRectMake(0, 0, self.image.size.height, self.image.size.width);
    float width = _contentImageView.image.size.width;
    float height = _contentImageView.image.size.height;
    
    _contentImageView.frame = CGRectMake(self.bounds.size.width/2 - width/2, self.bounds.size.height/2 - height/2, width, height);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.highlighted = YES;
    
    if ([_delegate respondsToSelector:@selector(newsCubeMenuItemTouchesBegan:)]) {
        [_delegate newsCubeMenuItemTouchesBegan:self];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // if move out of 2x rect, cancel select menu...
    CGPoint location = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location)) {
        self.highlighted = NO;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.highlighted = NO;
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location)) {
        if ([_delegate respondsToSelector:@selector(newsCubeMenuItemTouchesEnd:)]) {
            [_delegate newsCubeMenuItemTouchesEnd:self];
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.highlighted = NO;
}

#pragma mark -- ContentImage Highlight Method --
-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    [_contentImageView setHighlighted:highlighted];
}

@end
