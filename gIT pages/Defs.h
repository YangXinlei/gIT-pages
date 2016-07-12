//
//  Defs.h
//  gIT pages
//
//  Created by xl on 16/7/5.
//  Copyright © 2016年 xl. All rights reserved.
//

#ifndef Defs_h
#define Defs_h

// colors
#define LEMON_MAIN_COLOR [UIColor colorWithRed:0.13333f green:0.13333f blue:0.13333f alpha:1.0f]
#define LEMON_BLUE_COLOR [UIColor colorWithRed:0.19608f green:0.49804f blue:0.78039f alpha:1.0f]
#define LEMON_TINT_COLOR [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]

// titles
#define TITLE_HOMEPAGE                      @"头条精选"
#define TITLE_ACTIVITYPAGE                  @""
#define TITLE_SHAREPAGE                     @"分享"
#define TITLE_EXPLOREPAGE                   @"探索"
#define TITLE_MINEPAGE                      @"我的"

// size
#define WINDOW_WIDTH                        [[UIScreen mainScreen] bounds].size.width
#define WINDOW_HEIGHT                       [[UIScreen mainScreen] bounds].size.height
#define STATUSBAR_HEIGHT                    [[UIApplication sharedApplication] statusBarFrame].size.height
#define ASSERT_NAVBAR_HEIGHT                44.0
#define ASSERT_TABBAR_HEIGHT                49.0
#define HOME_POSTCELL_HEIGHT                ((WINDOW_HEIGHT - ASSERT_NAVBAR_HEIGHT - ASSERT_TABBAR_HEIGHT - STATUSBAR_HEIGHT) / 6.0)
#define SUBVIEW_HEIGHT                      WINDOW_HEIGHT - STATUSBAR_HEIGHT - ASSERT_NAVBAR_HEIGHT

#endif /* Defs_h */
