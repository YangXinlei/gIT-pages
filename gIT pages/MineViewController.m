//
//  MineViewController.m
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "MineViewController.h"
#import "WPTableViewCell.h"
#import "MineHeaderView.h"
#import "Defs.h"

#define HEADER_HEIGHT           (SUBVIEW_HEIGHT) / 3.0
#define MAIN_CELL_HEIGHT        (SUBVIEW_HEIGHT) * 2.0 / 3.0
#define LOGO_SIZE               60.0

#define WPCELL_REUSE            @"wpcell_reuse"

@interface MineViewController ()
@property (nonatomic, strong) UIImageView *headerImageView;
@end

@implementation MineViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        UIImage *headerImage = [UIImage imageNamed:@"MyHeaderImage"];
        _headerImageView = [[UIImageView alloc] initWithImage:headerImage];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self.tableView registerClass:[WPTableViewCell class] forCellReuseIdentifier:WPCELL_REUSE];

    [self.tableView setContentInset:UIEdgeInsetsMake(HEADER_HEIGHT, 0, 0, 0)];
    
    [_headerImageView setFrame:CGRectMake(0, -HEADER_HEIGHT, WINDOW_WIDTH, HEADER_HEIGHT)];
    [_headerImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.tableView addSubview:_headerImageView];
    [_headerImageView setAutoresizesSubviews:YES];
    
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:beffect];
    [blurView setFrame:CGRectMake(0, 0, WINDOW_WIDTH, HEADER_HEIGHT)];
    [blurView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_headerImageView addSubview:blurView];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me"]];
    [logoView setFrame:CGRectMake((WINDOW_WIDTH - LOGO_SIZE) / 2.0, (HEADER_HEIGHT - LOGO_SIZE) / 2.0, LOGO_SIZE, LOGO_SIZE)];
    [[logoView layer] setCornerRadius:LOGO_SIZE / 2.0];
    [logoView setClipsToBounds:YES];
    [logoView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [_headerImageView addSubview:logoView];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - table view data sourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WPTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:WPCELL_REUSE forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_CELL_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.y);
    
    CGFloat y = scrollView.contentOffset.y;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -HEADER_HEIGHT) {
        CGRect frame = _headerImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _headerImageView.frame = frame;
    }
}

@end
