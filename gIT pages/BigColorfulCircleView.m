//
//  BigColorfulCircleView.m
//  gIT pages
//
//  Created by xl on 16/7/22.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "BigColorfulCircleView.h"

#define  Text_Height                20.0f

@implementation BigColorfulCircleView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)titleStr
                  placeHolder:(NSString *)placeHolder
                      bgColor:(UIColor *)bgColor
                    tintColor:(UIColor *)tintColor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _bgColor = bgColor;
        _tintColor = tintColor;
        [self setBackgroundColor:bgColor];
        
        // 椭圆
        CGFloat minSize = MIN(frame.size.width, frame.size.height);
        [[self layer] setCornerRadius:minSize / 2.0];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, Text_Height)];
        [_titleLabel setTextColor:tintColor];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setText:titleStr];
        [_titleLabel sizeToFit];
        [_titleLabel setFrame:CGRectMake( (frame.size.width - _titleLabel.frame.size.width) / 2.0, (frame.size.height - _titleLabel.frame.size.height) / 3.0, _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
        [self addSubview:_titleLabel];
        
        CGFloat textFieldWidth = frame.size.width * 4 / 5.0;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake( (frame.size.width - textFieldWidth) / 2.0, (frame.size.height - Text_Height) * 2 / 3.0,textFieldWidth, Text_Height )];
        [_textField setPlaceholder:placeHolder];
        [_textField setTextColor:tintColor];
        [_textField setBackgroundColor:bgColor];
        [self addSubview:_textField];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
