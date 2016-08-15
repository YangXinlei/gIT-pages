//
//  BloggerTableViewCell.m
//  gIT pages
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "BloggerTableViewCell.h"

@interface BloggerTableViewCell ()

@property (nonatomic, strong)   UILabel         *nameLabel;
@property (nonatomic, strong)   UIImageView     *thumbnail;
@property (nonatomic, strong)   UILabel         *postsLabel;
@property (nonatomic, strong)   UIButton        *orderBtn;

@end

@implementation BloggerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithBlogger:(Blogger *)b
{
    
}

@end
