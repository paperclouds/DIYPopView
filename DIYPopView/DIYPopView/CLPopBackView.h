//
//  CLPopBackView.h
//  Nine_pieces_of_Nine
//
//  Created by culiu－mac01 on 14-3-6.
//  Copyright (c) 2014年 culiu－mac01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void ((^CLPopViewCloseBlock)(void));

@interface CLPopBackView : UIView

+ (CLPopBackView *)sharedInstance;
- (void)displayPopBackView:(UIView *)superView subView:(UIImageView *)subView;
- (void)displayPopBackView:(UIImageView *)subView;
- (void)addCloseGestureWithBlock:(CLPopViewCloseBlock)block;
- (void)removeCloseGesture;
- (void)close;
//ios7view的frame
@property(nonatomic,copy)NSString * alert;
@end
