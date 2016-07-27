//
//  BubbleDropBehavior.h
//  gIT pages
//
//  Created by xl on 16/7/26.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleDropBehavior : UIDynamicBehavior

- (void)addItem:(id<UIDynamicItem>)item;
- (void)removeItem:(id<UIDynamicItem>)item;

@end
