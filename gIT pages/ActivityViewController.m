//
//  ActivityViewController.m
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "ActivityViewController.h"
#import "ToggleView.h"

@interface ActivityViewController () <ToggleViewDelegate>

@end

@implementation ActivityViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    NSArray<NSString *> *barTitles = @[@"最新", @"最热", @"与我相关"];
    
    UIView *titleView = [[ToggleView alloc] initWithNames:barTitles delegate:self];
    
    [[self navigationItem] setTitleView:titleView];

}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)toggleView:(ToggleView *)view didToggleToIndex:(NSInteger)index
{
    NSLog(@"%s", __FUNCTION__);
}

@end
