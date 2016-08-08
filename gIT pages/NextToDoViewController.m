//
//  NextToDoViewController.m
//  gIT pages
//
//  Created by xl on 16/8/8.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "NextToDoViewController.h"
#import "Defs.h"

@interface NextToDoViewController ()

@end

@implementation NextToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[[self navigationController] navigationBar] setTranslucent:NO];
    [[[self navigationController] navigationBar] setBarTintColor:LEMON_MAIN_COLOR];
    
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closeBarItemClicked)];
    [[self navigationItem] setLeftBarButtonItem:leftBarBtnItem];
    
    [[self navigationItem] setTitle:@"NextToDo"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//MARK:actions

- (void)closeBarItemClicked
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:^{}];
}
@end
