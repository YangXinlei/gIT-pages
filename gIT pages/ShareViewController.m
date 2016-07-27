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

@property (nonatomic, strong) UIScrollView                     *bgScrollView;          // scrollView作为根，以达到弹出键盘时对位置进行灵活控制

// 文章标题
@property (nonatomic, strong) BigColorfulCircleView            *titleView;

// 文章链接
@property (nonatomic, strong) BigColorfulCircleView            *urlView;

// 提交
@property (nonatomic, strong) UIButton                          *submitBtn;

@end


@implementation ShareViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"我要分享"];
    [[[self navigationController] navigationBar] setBarTintColor:SUGER_GREEN];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:[self.view frame]];
    [_bgScrollView setAlwaysBounceHorizontal:NO];
    [_bgScrollView setAlwaysBounceVertical:YES];
    [_bgScrollView setDelegate:self];
    
    NSLog(@"%@", _bgScrollView);
    
    // 响应点击事件以收回键盘
    UITapGestureRecognizer *tapGesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTapped:)];
    [_bgScrollView addGestureRecognizer:tapGesRecognizer];
    
    
    [self.view addSubview:_bgScrollView];

    _titleView = [[BigColorfulCircleView alloc] initWithFrame:CGRectMake(0, 30.0, WINDOW_WIDTH, 150.0) title:@"文章标题" placeHolder:@"请填写待分享文章标题" bgColor:SUGER_GREEN tintColor:[UIColor whiteColor]];
    [_bgScrollView addSubview:_titleView];
    
    _urlView = [[BigColorfulCircleView alloc] initWithFrame:CGRectMake(0, 200, WINDOW_WIDTH, 250.0) title:@"文章链接" placeHolder:@"请填写待分享文章的url" bgColor:SUGER_BLUE tintColor:[UIColor whiteColor]];
    [_bgScrollView addSubview:_urlView];
    
    
    
    // 监听textField
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startInput) name:kshareTextFieldBeginNotification object:nil];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_submitBtn setBackgroundColor:LEMON_BLUE_COLOR];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[_submitBtn layer] setCornerRadius:10.0f];
    
    [_submitBtn setFrame:CGRectMake(WINDOW_WIDTH / 8.0, 500, WINDOW_WIDTH *6.0 / 8.0, 45.f)];
    [_bgScrollView addSubview:_submitBtn];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)bgViewTapped:(UITapGestureRecognizer *)recognizer
{
    [_bgScrollView endEditing:YES];
}

- (void)startInput
{
    
}

- (void)submitBtnClicked:(UIButton *)btn
{
    NSLog(@"%s", __FUNCTION__);
}

@end
