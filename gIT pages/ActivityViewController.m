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
#import "Blogger.h"
#import "ToggleView.h"
#import "Defs.h"

@interface ActivityViewController () <ToggleViewDelegate>

@property (nonatomic, strong) NSMutableArray       *vcArray;
@property (nonatomic, assign) NSInteger             curIndex;

@end

@implementation ActivityViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:LEMON_TINT_COLOR];
    
    NSArray<NSString *> *barTitles = @[@"最热", @"最新", @"与我相关"];
    
    UIView *titleView = [[ToggleView alloc] initWithNames:barTitles delegate:self];
    
    [[self navigationItem] setTitleView:titleView];
    
    _vcArray = [NSMutableArray arrayWithCapacity:[barTitles count]];
    
    PostItem *item = [[PostItem alloc] initWithTitle:@"abc" Url:@"https://yangxinlei.github.io/ios/2016/07/25/UIScrollView-contentSize-contentOffset-contentInset.html" Blogger:nil Twitter:nil Tag:nil Comments:nil Likes:0 Date:0];
    PostDetailViewController *hotPostVC = [[PostDetailViewController alloc] initWithPostItem:item];
    [_vcArray addObject:hotPostVC];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [_vcArray addObject:homeVC];
    
    Blogger *blogger = [[Blogger alloc] initWithName:@"杨鑫磊" url:nil];
    PostComment *comment1 = [[PostComment alloc] initWithPost:nil Blogger:blogger Content:@"lz我爱你" Date:@"2016-08-01T11:02:02+00:00"];
    PostComment *comment2 = [[PostComment alloc] initWithPost:nil Blogger:blogger Content:@"这篇文章不错" Date:@"2016-08-01T11:02:02+00:00"];
    NSArray<PostComment *> *commentArray = @[comment1, comment2];
    CommentsViewController *commentMeVC = [[CommentsViewController alloc] initWithComments:commentArray];
    [_vcArray addObject:commentMeVC];
    
    _curIndex = -1;
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
    if (_curIndex == -1)
    {
        [self.view addSubview:vc.view];
        
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
    else
    {
        if (index > _curIndex)
        {
            __block UIViewController *curVC = _vcArray[_curIndex];

            [UIView animateWithDuration:0.5 animations:^{
                [curVC.view setFrame:CGRectMake(-WINDOW_WIDTH, vc.view.frame.origin.y, vc.view.frame.size.width, vc.view.frame.size.height)];
            } completion:^(BOOL fin){
                [curVC.view removeFromSuperview];
                [curVC removeFromParentViewController];
                curVC = nil;
            }];
            [vc.view setFrame:CGRectMake(WINDOW_WIDTH, vc.view.frame.origin.y, vc.view.frame.size.width, vc.view.frame.size.height)];
        }
        else
        {
            __block UIViewController *curVC = _vcArray[_curIndex];
            
            [UIView animateWithDuration:0.5 animations:^{
                [curVC.view setFrame:CGRectMake(WINDOW_WIDTH, vc.view.frame.origin.y, vc.view.frame.size.width, vc.view.frame.size.height)];
            } completion:^(BOOL fin){
                [curVC.view removeFromSuperview];
                [curVC removeFromParentViewController];
                curVC = nil;
            }];
            [vc.view setFrame:CGRectMake(-WINDOW_WIDTH, vc.view.frame.origin.y, vc.view.frame.size.width, vc.view.frame.size.height)];
        }
        [self.view addSubview:vc.view];
        [UIView animateWithDuration:0.5 animations:^{
            [vc.view setFrame:CGRectMake(0, vc.view.frame.origin.y, vc.view.frame.size.width, vc.view.frame.size.height)];
        }];
        
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
}

@end
