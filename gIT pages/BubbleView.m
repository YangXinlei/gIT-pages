//
//  BubbleView.m
//  gIT pages
//
//  Created by xl on 16/7/26.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "BubbleView.h"
#import "Defs.h"

@interface BubbleView ()

@end


@implementation BubbleView

- (instancetype)initWithRandomFactor:(int)factor AndTitle:(NSString *)title
{
    // bubble 长宽
    // frame size: 120 - 220(120~160: 20%)(160~200: 70%)(200~220:10%)
    int dice = arc4random() % 10;
    int size;
    if (dice < 2)
    {
        size = arc4random() % 40;
    }
    else if (dice < 9)
    {
        size = arc4random() % 40;
        size += 40;
    }
    else
    {
        size = arc4random() % 20;
        size += 80;
    }
    size += 120;
    
    // bubble 开始点y坐标
    // 225 - 575
    int yStart = arc4random() % 200;
    yStart += 200 * (factor - 1);
    
    // bubble 开始点x坐标
    // 10 ~ WINDOW_WIDHT - 225
    int xStart = arc4random() % ((int)WINDOW_WIDTH - 215);
    xStart += 10;
    
    return [self initWithFrame:CGRectMake(xStart, yStart, size, size) title:title thumbnail:nil bgImage:nil];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title thumbnail:(UIImage *)thumbnail bgImage:(UIImage *)bgImage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (bgImage != nil)
        {
            UIImageView *bgView = [[UIImageView alloc] initWithImage:bgImage];
            [self addSubview:bgView];
        }
        else
        {
            // random bg color
            self.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:0.5 + (arc4random() % 50)/100];
        }
        
        // ios 9 支持圆形碰撞边界
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
        {
            self.layer.cornerRadius = frame.size.width / 2;
        }
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 0, 0)];
        [_titleLabel setText:title];
        [_titleLabel sizeToFit];
        
        [_titleLabel setFrame:CGRectMake((frame.size.width - _titleLabel.frame.size.width) / 2, (frame.size.height - _titleLabel.frame.size.height) / 2, _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
        
        [self addSubview:_titleLabel];
    }
    return self;
}

- (UIDynamicItemCollisionBoundsType)collisionBoundsType
{
    return UIDynamicItemCollisionBoundsTypeEllipse;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
