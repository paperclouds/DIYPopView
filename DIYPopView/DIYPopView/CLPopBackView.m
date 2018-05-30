//
//  CLPopBackView.m
//  Nine_pieces_of_Nine
//
//  Created by culiu－mac01 on 14-3-6.
//  Copyright (c) 2014年 culiu－mac01. All rights reserved.
//

#import "CLPopBackView.h"
#import "AppDelegate.h"

//屏幕尺寸
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue]< 8.0&&[[[UIDevice currentDevice] systemVersion] floatValue]>= 7.0)

#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@implementation CLPopBackView{
    UIButton *hiddenButton;
    CLPopViewCloseBlock closeBlock;
    UIView *_subView;
}

static CLPopBackView *_defaultPopView;

+ (CLPopBackView *)sharedInstance {
    if (_defaultPopView == nil) {
        _defaultPopView = [[CLPopBackView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _defaultPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _defaultPopView.userInteractionEnabled = YES;
    }
    return _defaultPopView;
}

-(void)layoutSubviews
{
    if ([self.alert isEqualToString:@"alert"] && iOS7) {
        _defaultPopView.frame =CGRectMake(0, 0, screenHeight, screenWidth);

    }
    else{
        
        _defaultPopView.frame = CGRectMake(0, 0, screenWidth, screenHeight);

    
    }
    hiddenButton.frame = _defaultPopView.bounds;
    
    _subView.center = _defaultPopView.center;

}
- (void)displayPopBackView:(UIView *)superView subView:(UIImageView *)subView {
    for (UIView *view in _defaultPopView.subviews) {
        if (view != nil) {
            [view removeFromSuperview];
        }
    }
    _subView=subView;
    _defaultPopView.frame = CGRectMake(superView.frame.origin.x, superView.frame.size.height, superView.frame.size.width, superView.frame.size.height);
    subView.userInteractionEnabled=YES;
    subView.center = _defaultPopView.center;
    hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hiddenButton.backgroundColor = [UIColor clearColor];
    hiddenButton.frame = _defaultPopView.bounds;
    [hiddenButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    hiddenButton.hidden = YES;
    hiddenButton.exclusiveTouch = YES;
    [_defaultPopView addSubview:hiddenButton];
    [_defaultPopView addSubview:subView];
    _defaultPopView.hidden = NO;
    [superView addSubview:_defaultPopView];
    [superView bringSubviewToFront:_defaultPopView];

    [UIView animateWithDuration:0.3 animations:^{
        _defaultPopView.frame = superView.bounds;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _defaultPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        }];
    }];
}

- (void)displayPopBackView:(UIImageView *)subView {
    subView.userInteractionEnabled=YES;
    [self displayPopBackView:kAppDelegate.window subView:subView];
}

- (void)close {
    for (UIGestureRecognizer *gesture in _defaultPopView.gestureRecognizers) {
        [_defaultPopView removeGestureRecognizer:gesture];
    }
    
    for (UIView *view in _defaultPopView.subviews) {
        if (view != nil) {
            [view removeFromSuperview];
        }
    }
    [_defaultPopView removeFromSuperview];
    _defaultPopView.hidden = YES;
    _defaultPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
}

-(void)closeAction{
    if (closeBlock) {
        closeBlock();
    }
}

-(void)addCloseGestureWithBlock:(CLPopViewCloseBlock)block{
    closeBlock = block;
    hiddenButton.hidden = NO;
}

-(void)removeCloseGesture{
    closeBlock = nil;
    hiddenButton.hidden = YES;
}

@end
