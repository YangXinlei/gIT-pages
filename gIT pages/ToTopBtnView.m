//
//  ToTopBtnView.m
//  gIT pages
//
//  Created by xl on 16/7/22.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "ToTopBtnView.h"
#import "Defs.h"

@interface ToTopBtnView ()

@property (nonatomic, strong) UIImageView           *imgView;

@end

@implementation ToTopBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIImage *img = [UIImage imageNamed:@"ToTop.png"];
        _imgView = [[UIImageView alloc] initWithImage:img];
        [self addSubview:_imgView];
        
        _isShowing = NO;
        [self setAlpha:0.0];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//
//}

#pragma mark - 显示／消失动画

- (void)appearWithDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        [self setAlpha:0.8];
    }];
    _isShowing = YES;
    [self setUserInteractionEnabled:YES];
}

- (void)disappearAndRemoveWithDuration:(NSTimeInterval)duration
{
    [self setUserInteractionEnabled:NO];
    
    [UIView animateWithDuration:duration animations:^{
        [self setAlpha:0.0];
    }completion:^(BOOL finished){
        if (finished)
        {
            _isShowing = NO;
            [self removeFromSuperview];
        }
    }];
}

#pragma 点击事件

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kToTopNotification object:nil];
    [self disappearAndRemoveWithDuration:0.5];
}

@end
