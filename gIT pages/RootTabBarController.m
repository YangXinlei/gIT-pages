//
//  RootTabBarController.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//
#import "Defs.h"
#import "RootTabBarController.h"
#import "HomeViewController.h"
#import "ActivityViewController.h"
#import "ShareViewController.h"
#import "ExploreViewController.h"
#import "MineViewController.h"

@implementation RootTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[self tabBar] setTranslucent:NO];
    [[self tabBar] setBackgroundColor:[UIColor whiteColor]];
    [[self tabBar] setTintColor:LEMON_MAIN_COLOR];
//    [self setHidesBottomBarWhenPushed:YES];
    
    // 5个viewController
    HomeViewController *homeVC              =   [[HomeViewController alloc] init];
    ActivityViewController *activityVC      =   [[ActivityViewController alloc] init];
    ShareViewController *shareVC            =   [[ShareViewController alloc] init];
    ExploreViewController *exploreVC        =   [[ExploreViewController alloc] init];
    MineViewController *mineVC              =   [[MineViewController alloc] init];
    NSArray<UIViewController *> *rootViewControllers = @[homeVC, activityVC, shareVC, exploreVC, mineVC];
    
    // 5个title
    NSArray *titles = @[@"精选", @"动态", @"", @"发现", @"我的"];
    
    NSMutableArray *navViewControllers = [NSMutableArray arrayWithCapacity:5];
    for (int index = 0; index < [rootViewControllers count]; ++index)
    {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[rootViewControllers objectAtIndex:index]];
        [[navigationController navigationBar] setTranslucent:NO];
        [[navigationController navigationBar] setTintColor:LEMON_BLUE_COLOR];
        [[navigationController navigationBar] setBarTintColor:LEMON_MAIN_COLOR];
        [[navigationController navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName:LEMON_TINT_COLOR}];
        
        [navigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:titles[index] image:[[UIImage imageNamed:[NSString stringWithFormat:@"tb_normal_%d", index + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"tb_focus_%d", index + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
        
        // 中间添加按钮
        if (index == 2)
        {
            [[navigationController tabBarItem] setImageInsets:UIEdgeInsetsMake(4, 0, -4, 0)];
        }
        
        [navViewControllers addObject:navigationController];
    }
    
    [self setViewControllers:navViewControllers animated:YES];
    [self setSelectedIndex:1];
}

@end
