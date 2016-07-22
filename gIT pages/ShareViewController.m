//
//  ShareViewController.m
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "ShareViewController.h"
#import "BigColorfulCircleView.h"
#import "Defs.h"
@interface ShareViewController ()

// 文章标题
@property (nonatomic, strong) BigColorfulCircleView            *titleView;

// 文章链接
@property (nonatomic, strong) BigColorfulCircleView            *urlView;

// 提交
@property (nonatomic, strong) UIButton          *submitBtn;

@end


@implementation ShareViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"我要分享"];
    UIColor *suger_blue = [UIColor colorWithRed:20.0/255.0 green:121.0/255.0 blue:211.0/255.0 alpha:1.0];
    UIColor *suger_green = [UIColor colorWithRed:75.0/255.0 green:194.0/255.0 blue:112.0/255.0 alpha:1.0];
    UIColor *suger_yellow = [UIColor colorWithRed:218.0/255.0 green:233.0/255.0 blue:37.0/255.0 alpha:1.0];
    
    [self.view setBackgroundColor:suger_yellow];

    _titleView = [[BigColorfulCircleView alloc] initWithFrame:CGRectMake(0, 30.0, WINDOW_WIDTH, 150.0) title:@"文章标题" placeHolder:@"请填写待分享文章标题" bgColor:suger_green tintColor:suger_yellow];
    [self.view addSubview:_titleView];
    
    _urlView = [[BigColorfulCircleView alloc] initWithFrame:CGRectMake(0, 200.0, WINDOW_WIDTH, 250.0) title:@"文章链接" placeHolder:@"请填写待分享文章的url" bgColor:suger_blue tintColor:suger_yellow];
    [self.view addSubview:_urlView];
    
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
