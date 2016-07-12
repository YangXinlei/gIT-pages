//
//  PostTableViewCell.h
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostItem;
@class PostCellViewController;
// 文章Cell
@interface PostTableViewCell : UITableViewCell

@property (nonatomic, strong) PostCellViewController *postCellVC;

- (void)setupWithPostItem:(PostItem *)item;

@end
