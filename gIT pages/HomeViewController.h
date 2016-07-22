//
//  HomeViewController.h
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostItem.h"

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;                               // 首页主要由tableView组成

@property (nonatomic, strong) NSArray<PostItem *> *posts;                // 首页需要展示的文章

@end
