//
//  ToggleView.h
//  gIT pages
//
//  Created by xl on 16/8/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToggleView;

@protocol ToggleViewDelegate <NSObject>

- (void)toggleView:(ToggleView *)view didToggleToIndex:(NSInteger)index;

@end

@interface ToggleView : UIView

@property (nonatomic, strong) id<ToggleViewDelegate>    delegate;

-(instancetype)initWithNames:(NSArray<NSString *> *)names delegate:(id<ToggleViewDelegate>)delegate;

@end
