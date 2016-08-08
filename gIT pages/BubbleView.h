//
//  BubbleView.h
//  gIT pages
//
//  Created by xl on 16/7/26.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleView : UIView

@property (nonatomic, strong) UILabel           *titleLabel;                 // 显示标题
@property (nonatomic, strong) UIImage           *thumbnail;                  // 头像
@property (nonatomic, strong) UIImage           *bgImage;                    // 背景图片

// action
@property (nonatomic, copy) void (^actionBlock)(void);


- (instancetype)initWithRandomFactor:(int)factor andTitle:(NSString *)title andAction:(void (^)(void))action;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title thumbnail:(UIImage *)thumbnail bgImage:(UIImage *)bgImage action:(void (^)(void))action;

@end
