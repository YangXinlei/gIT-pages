//
//  CommentView.m
//  gIT pages
//
//  Created by xl on 16/7/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "CommentView.h"
#import "PostComment.h"
#import "Blogger.h"
#import "Defs.h"

#define COMMENT_HEIGHT              40.0f
#define MARGIN_OFFSET               10.0f

@interface CommentView ()

@property (nonatomic, strong) PostComment *comment;

@end

@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame PostComment:(PostComment *)comment
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _comment = comment;
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGFloat yStart = 0.0f;
        // 内容label
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_OFFSET, MARGIN_OFFSET, WINDOW_WIDTH - MARGIN_OFFSET * 2, 0)];
        [contentLabel setText:[_comment content]];
        [contentLabel setNumberOfLines:0];
        [contentLabel sizeToFit];
        [self addSubview:contentLabel];
        
        yStart += [contentLabel frame].size.height + MARGIN_OFFSET;
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_OFFSET, yStart, 0, 0)];
        NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc] init];
        [tmpFormatter setDateFormat:@"YYYY'/'MM'/'dd'-'HH':'mm':'ss"];
        NSString *dateStr = [tmpFormatter stringFromDate:[_comment date]];
        [dateLabel setText:dateStr];
        [dateLabel sizeToFit];
        [self addSubview:dateLabel];
        
        // 评论人label
        UILabel *bloggerLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_OFFSET, yStart, WINDOW_WIDTH, 0)];
        [bloggerLabel setText:[[_comment blogger] name]];
        [bloggerLabel setNumberOfLines:0];
        [bloggerLabel sizeToFit];
        CGFloat labelWidth = [bloggerLabel frame].size.width;
        CGFloat labelHeight = [bloggerLabel frame].size.height;
        [bloggerLabel setFrame:CGRectMake(WINDOW_WIDTH - labelWidth - MARGIN_OFFSET, [bloggerLabel frame].origin.y, labelWidth, labelHeight)];
        [self addSubview:bloggerLabel];
        
        yStart += labelHeight + MARGIN_OFFSET;
        
        [self setFrame:CGRectMake([self frame].origin.x, [self frame].origin.y, [self frame].size.width, yStart)];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}


@end
