//
//  DIYPopView.m
//  DIYPopView
//
//  Created by paperclouds on 2018/5/30.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import "DIYPopView.h"
#import "CLPopBackView.h"
#import "CollectionViewCell.h"

#define cellID @"cellID"
#define screenWidth [UIScreen mainScreen].bounds.size.width

@implementation DIYPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initView{
    self = [super init];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews{
    self.frame = CGRectMake(30, 100, 315, 400);
    self.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 315, 350)];
    [self addSubview:scrollView];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 100, 50)];
    [self addSubview:self.label];
    self.label.text = @"当前商品";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, 315, 300) collectionViewLayout:layout];
    [self addSubview:collectionView];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 350, 157.5, 50)];
    [self addSubview:confirmBtn];
    [confirmBtn setBackgroundColor:[UIColor blueColor]];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(157.5, 350, 157.5, 50)];
    [self addSubview:cancelBtn];
    [cancelBtn setBackgroundColor:[UIColor purpleColor]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)confirm{
    if (self.confirmButtonAction) {
        self.confirmButtonAction(self.label.text);
    }
    [[CLPopBackView sharedInstance] close];
}

- (void)cancel{
    if (self.cancelButtonAction) {
        self.cancelButtonAction();
    }
    [[CLPopBackView sharedInstance] close];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.titleLbl.text = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((screenWidth-5*2)/3, 90*screenWidth/375);
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.label.text = self.dataArray[indexPath.item];
}

-(void)showAlert{
    [self layoutSubviews];
    [[CLPopBackView sharedInstance] displayPopBackView:self];
//    if (!_cancelTitle&&!_confirmTitle) {
//        __weak typeof(self) weakSelf=self;
//        [[CLPopBackView sharedInstance] addCloseGestureWithBlock:^{
//            [weakSelf cancelButtonClick];
//        }];
//    }
}

@end
