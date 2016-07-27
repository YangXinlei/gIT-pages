//
//  BubbleDropBehavior.m
//  gIT pages
//
//  Created by xl on 16/7/26.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "BubbleDropBehavior.h"

@interface BubbleDropBehavior ()

@property (nonatomic, strong) UIGravityBehavior     *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior   *collisionBehavior;

@end

@implementation BubbleDropBehavior

- (UIGravityBehavior *)gravityBehavior
{
    if (!_gravityBehavior)
    {
        _gravityBehavior = [[UIGravityBehavior alloc] init];
        [_gravityBehavior setMagnitude:0.9];
    }
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior
{
    if (!_collisionBehavior)
    {
        _collisionBehavior = [[UICollisionBehavior alloc] init];
        [_collisionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
    }
    return _collisionBehavior;
}

- (void)addItem:(id<UIDynamicItem>)item
{
    [self.gravityBehavior addItem:item];
    [self.collisionBehavior addItem:item];
}

- (void)removeItem:(id<UIDynamicItem>)item
{
    [self.gravityBehavior removeItem:item];
    [self.collisionBehavior removeItem:item];
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self addChildBehavior:self.gravityBehavior];
        [self addChildBehavior:self.collisionBehavior];
    }
    return self;
}

@end
