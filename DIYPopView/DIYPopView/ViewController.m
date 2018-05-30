//
//  ViewController.m
//  DIYPopView
//
//  Created by paperclouds on 2018/5/30.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import "ViewController.h"
#import "DIYPopView.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *lbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lbl = [[UILabel alloc]initWithFrame:CGRectMake(150, 200, 100, 50)];
    [self.view addSubview:self.lbl];
    self.lbl.text = @"选择商品";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(150, 400, 100, 50)];
    [self.view addSubview:btn];
    [btn setTitle:@"弹出窗口" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
}

// 弹出窗口
- (void)popView{
    DIYPopView *popView = [[DIYPopView alloc]initView];
    popView.dataArray = @[@"1",@"2",@"3",@"4",@"da",@"wrew",@"sfd"];
    popView.label.text = self.lbl.text;
    [popView showAlert];
    
    popView.confirmButtonAction = ^(NSString *str) {
        self.lbl.text = str;
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
