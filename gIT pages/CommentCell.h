//
//  CommentCell.h
//  gIT pages
//
//  Created by xl on 16/7/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostComment;
@class CommentView;

@interface CommentCell : UITableViewCell

@property (nonatomic, strong)CommentView *commentView;

- (void)setupWithComment:(PostComment *)comment;
@end
