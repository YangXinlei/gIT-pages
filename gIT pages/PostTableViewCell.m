//
//  PostTableViewCell.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostTableViewCell.h"
#import "PostItem.h"

@implementation PostTableViewCell

- (void)setupWithPostItem:(PostItem *)item
{
    [self.textLabel setText:item.title];
}

@end
