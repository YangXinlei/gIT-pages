//
//  MineViewController.m
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "MineViewController.h"
#import "MineView.h"
#import "Defs.h"
#import "NextToDoViewController.h"


@interface MineViewController ()

@property (nonatomic, strong) MineView          *mineView;          // main view
@property (nonatomic, strong) NSArray           *bubbleActionArray;

@end

@implementation MineViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    __block typeof(self) weakSelf = self;
    _bubbleActionArray = @[
                           ^{
                               UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[NextToDoViewController alloc] init]];
                               
                               [weakSelf presentViewController:navController animated:YES completion:^{}];
                           },
                            ^{
                                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[NextToDoViewController alloc] init]];
                                
                                [weakSelf presentViewController:navController animated:YES completion:^{}];
                            },
                            ^{
                                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[NextToDoViewController alloc] init]];
                                
                                [weakSelf presentViewController:navController animated:YES completion:^{}];
                            },
                            ^{
                                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[NextToDoViewController alloc] init]];
                                
                                [weakSelf presentViewController:navController animated:YES completion:^{}];
                            },
                            ^{
                                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[NextToDoViewController alloc] init]];
                                
                                [weakSelf presentViewController:navController animated:YES completion:^{}];
                            }
                            ];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _mineView = [[MineView alloc] initWithFrame:CGRectMake(0, -800, self.view.frame.size.width, 800 + self.view.frame.size.height) andActions:_bubbleActionArray];
    [self.view addSubview:_mineView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_mineView removeFromSuperview];
    _mineView = nil;
}

@end
