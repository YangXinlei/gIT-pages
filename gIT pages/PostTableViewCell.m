//
//  PostTableViewCell.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostTableViewCell.h"
#import "PostItem.h"
#import "PostCellViewController.h"

@implementation PostTableViewCell

- (void)setupWithPostItem:(PostItem *)item
{
    if (_postCellVC)
    {
        [_postCellVC.view removeFromSuperview];
    }
    
    _postCellVC = [[PostCellViewController alloc] initWithPostItem:item];
    
    [self.contentView addSubview:_postCellVC.view];
}

@end

