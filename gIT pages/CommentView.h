//
//  CommentView.h
//  gIT pages
//
//  Created by xl on 16/7/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostComment;

@interface CommentView : UIView

- (instancetype)initWithFrame:(CGRect)frame PostComment:(PostComment *)comment;

@end
