//
//  ToTopBtnView.h
//  gIT pages
//
//  Created by xl on 16/7/22.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToTopBtnView : UIView

@property (nonatomic) BOOL isShowing;

- (void)appearWithDuration:(NSTimeInterval)duration;
- (void)disappearAndRemoveWithDuration:(NSTimeInterval)duration;

@end
