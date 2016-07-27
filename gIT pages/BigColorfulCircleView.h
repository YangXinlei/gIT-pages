//
//  BigColorfulCircleView.h
//  gIT pages
//
//  Created by xl on 16/7/22.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigColorfulCircleView : UIView <UITextFieldDelegate>

// 元素
@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UITextField       *textField;

// 颜色
@property (nonatomic, strong) UIColor           *bgColor;
@property (nonatomic, strong) UIColor           *tintColor;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)titleStr
                  placeHolder:(NSString *)placeHolder
                      bgColor:(UIColor *)bgColor
                    tintColor:(UIColor *)tintColor;
@end
