//
//  PostCellViewController.h
//  gIT pages
//
//  Created by xl on 16/7/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostItem;

@interface PostCellViewController : UIViewController

@property (nonatomic, strong) PostItem *item;

- (instancetype) initWithPostItem:(PostItem *)item;

@end
