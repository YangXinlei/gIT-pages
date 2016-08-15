//
//  BloggerTableViewCell.h
//  gIT pages
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blogger.h"

@interface BloggerTableViewCell : UITableViewCell

@property (nonatomic, strong) Blogger *blogger;

- (void)setupWithBlogger:(Blogger *)b;

@end
