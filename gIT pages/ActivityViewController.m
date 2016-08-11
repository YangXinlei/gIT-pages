//
//  ActivityViewController.m
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "ActivityViewController.h"
#import "HomeViewController.h"
#import "PostDetailViewController.h"
#import "CommentsViewController.h"
#import "PostItem.h"
#import "PostComment.h"
#import "ToggleView.h"

@interface ActivityViewController () <ToggleViewDelegate>

@property (nonatomic, strong) NSMutableArray       *vcArray;
@property (nonatomic, assign) NSInteger             curIndex;

@end

@implementation ActivityViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    NSArray<NSString *> *barTitles = @[@"最新", @"最热", @"与我相关"];
    
    UIView *titleView = [[ToggleView alloc] initWithNames:barTitles delegate:self];
    
    [[self navigationItem] setTitleView:titleView];
    
    _vcArray = [NSMutableArray arrayWithCapacity:[barTitles count]];
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [_vcArray addObject:homeVC];
    
    PostItem *item = [[PostItem alloc] initWithTitle:@"abc" Url:@"https://yangxinlei.github.io/ios/2016/07/25/UIScrollView-contentSize-contentOffset-contentInset.html" Blogger:nil Twitter:nil Tag:nil Comments:nil Likes:0 Date:0];
    PostDetailViewController *hotPostVC = [[PostDetailViewController alloc] initWithPostItem:item];
    [_vcArray addObject:hotPostVC];
    
    PostComment *comment1 = [[PostComment alloc] initWithPost:nil Blogger:nil Content:@"lz我爱你" Date:@"2016.8"];
    PostComment *comment2 = [[PostComment alloc] initWithPost:nil Blogger:nil Content:@"这篇文章不错" Date:@"2016.3"];
    NSArray<PostComment *> *commentArray = @[comment1, comment2];
    CommentsViewController *commentMeVC = [[CommentsViewController alloc] initWithComments:commentArray];
    [_vcArray addObject:commentMeVC];
    
    [self loadViewAtIndex:0];
    _curIndex = 0;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)toggleView:(ToggleView *)view didToggleToIndex:(NSInteger)index
{
    [self loadViewAtIndex:index];
    _curIndex = index;
}

- (void)loadViewAtIndex:(NSInteger)index
{
    UIViewController *vc = _vcArray[index];
    UIViewController *curVC = _vcArray[_curIndex];
    
    [curVC.view removeFromSuperview];
    [curVC removeFromParentViewController];
    curVC = nil;
    
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
}

@end
