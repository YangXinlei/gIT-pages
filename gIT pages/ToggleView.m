//
//  ToggleView.m
//  gIT pages
//
//  Created by xl on 16/8/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "ToggleView.h"
#import "Defs.h"

#define BAR_LENGTH              30.0f
#define BAR_HEIGHT              2.0f
#define TITLE_SIZE_NORMAL       18
#define TITLE_SIZE_FOCUS        20
#define GAP_LENGTH              40.0f
#define BAR_MOVE_SPEED_SQRT     15.0f
#define BAR_TOP_GAP             2.0f

@interface ToggleView()

@property (nonatomic, strong) NSMutableArray<UIButton *>    *buttons;
@property (nonatomic, strong) UIView                        *barView;
@property (nonatomic, assign) NSInteger                     curIndex;

@end

@implementation ToggleView

- (instancetype)initWithNames:(NSArray<NSString *> *)names delegate:(id<ToggleViewDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        _barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BAR_LENGTH, BAR_HEIGHT)];
        [_barView setBackgroundColor:LEMON_TINT_COLOR];
        _curIndex = -1;
        
        CGFloat xStart = 0.0f;
        CGFloat yStart = 0.0f;
        _buttons = [NSMutableArray<UIButton *> arrayWithCapacity:2];
        for (int i = 0; i < [names count]; ++i)
        {
            NSString *text = names[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [btn setTintColor:LEMON_TINT_COLOR];
            NSMutableAttributedString *titleStrNormal = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TITLE_SIZE_NORMAL]}];
            [btn setAttributedTitle:titleStrNormal forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(xStart, 0, 0, 0)];
            [btn sizeToFit];
            
            xStart += btn.frame.size.width + GAP_LENGTH;
            yStart = btn.frame.size.height;
            
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:i];
            
            [self addSubview:btn];
            [_buttons addObject:btn];
        }
        [self setFrame:CGRectMake(0, 0, xStart - GAP_LENGTH, yStart + BAR_HEIGHT + BAR_TOP_GAP)];
        if ([_buttons count] > 0)
        {
            [self moveBarToIndex:0];
            [self addSubview:_barView];
        }
    }
    return self;
}

- (void)btnClicked:(UIButton *)btn
{
    [self moveBarToIndex:btn.tag];
    [_delegate toggleView:self didToggleToIndex:btn.tag];
}

- (void)moveBarToIndex:(NSInteger)index
{
    if (index > [_buttons count])
        return;
    UIButton *btn = _buttons[index];
    
    if (_curIndex == -1)
    {
        [_barView setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y + btn.frame.size.height, btn.frame.size.width, BAR_HEIGHT)];
        _curIndex = index;
        return;
    }
    
    UIButton *curBtn = _buttons[_curIndex];
    CGFloat distance = fabs(btn.frame.origin.x - curBtn.frame.origin.x);
    
    [UIView animateWithDuration:(distance / (BAR_MOVE_SPEED_SQRT * BAR_MOVE_SPEED_SQRT)) animations:^{
        [_barView setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y + btn.frame.size.height, btn.frame.size.width, BAR_HEIGHT)];
    }];
    _curIndex = index;
}

@end
