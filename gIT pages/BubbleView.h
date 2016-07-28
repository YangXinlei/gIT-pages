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


- (instancetype)initWithRandomFactor:(int)factor AndTitle:(NSString *)title;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title thumbnail:(UIImage *)thumbnail bgImage:(UIImage *)bgImage;

@end
