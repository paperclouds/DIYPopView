//
//  DIYPopView.h
//  DIYPopView
//
//  Created by paperclouds on 2018/5/30.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void ((^DIYButtonActionBlock)(void));

typedef void ((^ConfirmActionBlock)(NSString *str));

@interface DIYPopView : UIImageView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) DIYButtonActionBlock cancelButtonAction;
@property (nonatomic, copy) ConfirmActionBlock confirmButtonAction;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic ,strong) NSArray *dataArray;

- (id)initView;
-(void)showAlert;

@end
