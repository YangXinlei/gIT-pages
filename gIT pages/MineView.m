//
//  MineView.m
//  gIT pages
//
//  Created by xl on 16/7/26.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "MineView.h"
#import "BubbleView.h"
#import "BubbleDropBehavior.h"

@interface MineView()

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) BubbleDropBehavior *dropBehavior;

@property (nonatomic, strong) BubbleView           *userBubble;
@property (nonatomic, strong) BubbleView           *watchBubble;
@property (nonatomic, strong) BubbleView           *shareBubble;
@property (nonatomic, strong) BubbleView           *collectBubble;

@end

@implementation MineView

- (UIDynamicAnimator *)animator
{
    if (!_animator)
    {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        
    }
    return _animator;
}

- (BubbleDropBehavior *)dropBehavior
{
    if (!_dropBehavior)
    {
        _dropBehavior = [[BubbleDropBehavior alloc] init];
        [self.animator addBehavior:_dropBehavior];
    }
    return _dropBehavior;
}

- (instancetype)initWithFrame:(CGRect)frame andActions:(NSArray *)actions
{
    self = [super initWithFrame:frame];
    if (self)
    {
        int i = 1;
        _userBubble = [[BubbleView alloc] initWithRandomFactor:i andTitle:@"鑫磊" andAction:^{
            if ([actions count] >= i)
            {
                void(^ action)(void) = actions[i - 1];
                if (action != nil)
                {
                    action();
                }
            }
        }];
        ++i;
        _shareBubble = [[BubbleView alloc] initWithRandomFactor:i andTitle:@"分享\t16" andAction:^{
            if ([actions count] >= i)
            {
                void(^ action)(void) = actions[i - 1];
                if (action != nil)
                {
                    action();
                }
            }
        }];
        ++i;
        _watchBubble = [[BubbleView alloc] initWithRandomFactor:i andTitle:@"关注\t42" andAction:^{
            if ([actions count] >= i)
            {
                void(^ action)(void) = actions[i - 1];
                if (action != nil)
                {
                    action();
                }
            }
        }];
        ++i;
        _collectBubble = [[BubbleView alloc] initWithRandomFactor:i andTitle:@"收藏\t3" andAction:^{
            if ([actions count] >= i)
            {
                void(^ action)(void) = actions[i - 1];
                if (action != nil)
                {
                    action();
                }
            }
        }];
        
        [self addSubview:_userBubble];
        [self addSubview:_shareBubble];
        [self addSubview:_watchBubble];
        [self addSubview:_collectBubble];
        
        [self.dropBehavior addItem:_userBubble];
        [self.dropBehavior addItem:_shareBubble];
        [self.dropBehavior addItem:_watchBubble];
        [self.dropBehavior addItem:_collectBubble];
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
