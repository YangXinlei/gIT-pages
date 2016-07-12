//
//  CommentCell.m
//  gIT pages
//
//  Created by xl on 16/7/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "CommentCell.h"
#import "CommentView.h"
#import "PostComment.h"
#import "Defs.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithComment:(PostComment *)comment
{
    _commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 0) PostComment:comment];
    
    [self.contentView addSubview:_commentView];
}

@end
