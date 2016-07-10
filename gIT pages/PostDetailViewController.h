//
//  PostDetailViewController.h
//  gIT pages
//
//  Created by xl on 16/7/10.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  PostItem;
@interface PostDetailViewController : UIViewController

@property (nonatomic, strong) PostItem *post;               // 文章
@property (nonatomic, strong) UIWebView *postWebView;       // 使用一个webView展示文章内容

- (instancetype)initWithPostItem:(PostItem *)post;

@end
