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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _userBubble = [[BubbleView alloc] initWithRandomFrameAndTitle:@"鑫磊"];
        _shareBubble = [[BubbleView alloc] initWithRandomFrameAndTitle:@"分享\t16"];
        _watchBubble = [[BubbleView alloc] initWithRandomFrameAndTitle:@"关注\t42"];
        _collectBubble = [[BubbleView alloc] initWithRandomFrameAndTitle:@"收藏\t3"];
        
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
