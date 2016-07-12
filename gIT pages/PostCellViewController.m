//
//  PostCellViewController.m
//  gIT pages
//
//  Created by xl on 16/7/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostCellViewController.h"
#import "PostItem.h"
#import "Blogger.h"
#import "Defs.h"

#define FONT_COLOR_NORMAL               [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]
#define FONT_COLOR_VIEWED               [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8]


#define MARGIN_TOP                      15.0f
#define MARGIN_BOTTOM                   8.0
#define TITLE_MARGIN_RIGHT              55.0
#define MARGIN_HORIZENTAL               15.0f
#define BTN_SIZE                        26.0
#define NUM_FONT_SIZE                  12.0f
#define NAME_FONT_SIZE                  12.0f
#define BTN_GAP                         8.0

@interface PostCellViewController ()

@property (nonatomic, strong) UILabel   *contentLabel;
@property (nonatomic, strong) UILabel   *likeLabel;
@property (nonatomic, strong) UILabel   *commentLabel;
@property (nonatomic, strong) UIButton  *likeButton;
@property (nonatomic, assign) BOOL      liking;                    // 记录likebtn当前状态

@end

@implementation PostCellViewController

- (instancetype)initWithPostItem:(PostItem *)item
{
    self = [super init];
    if (self)
    {
        _item = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setFrame:CGRectMake(0, 0, WINDOW_WIDTH, HOME_POSTCELL_HEIGHT)];
    
    // 文章title
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_HORIZENTAL, MARGIN_TOP,WINDOW_WIDTH - MARGIN_HORIZENTAL - TITLE_MARGIN_RIGHT, 0)];
    [_contentLabel setNumberOfLines:0];
    [_contentLabel setText:[_item title]];
    [_contentLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [_contentLabel setTextColor:FONT_COLOR_NORMAL];
    [_contentLabel sizeToFit];
    [self.view addSubview:_contentLabel];
    
    CGFloat xStart = MARGIN_HORIZENTAL;
    CGFloat yStart = HOME_POSTCELL_HEIGHT - BTN_SIZE - MARGIN_BOTTOM;
    // 点赞按钮
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setFrame:CGRectMake(xStart, yStart, BTN_SIZE, BTN_SIZE)];
    [_likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBtn_Normal"] forState:UIControlStateNormal];
    [_likeButton addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_likeButton];
    _liking = NO;
    
    xStart += BTN_SIZE;
    // 点赞数
    _likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(xStart, yStart, 0, 0)];
    [_likeLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)[_item likes]]];
    [_likeLabel setFont:[UIFont systemFontOfSize:NUM_FONT_SIZE]];
    [_likeLabel setTextColor:[UIColor lightGrayColor]];
    [_likeLabel sizeToFit];
    [_likeLabel setCenter:CGPointMake(xStart + [_likeLabel frame].size.width / 2.0, yStart + BTN_SIZE / 2.0)];
    [self.view addSubview:_likeLabel];
    
    xStart += [_likeLabel frame].size.width + BTN_GAP;
    // 点赞按钮
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setFrame:CGRectMake(xStart, yStart, BTN_SIZE, BTN_SIZE)];
    [commentBtn setBackgroundImage:[UIImage imageNamed:@"CommentBtn_Normal"] forState:UIControlStateNormal];
    [commentBtn setBackgroundImage:[UIImage imageNamed:@"CommentBtn_Focus"] forState:UIControlStateFocused];
    [commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentBtn];
    
    xStart += BTN_SIZE;
    // 点赞数
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(xStart, yStart, 0, 0)];
    [_commentLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)[[_item comments] count]]];
    [_commentLabel setTextColor:[UIColor lightGrayColor]];
    [_commentLabel setFont:[UIFont systemFontOfSize:NUM_FONT_SIZE]];
    [_commentLabel sizeToFit];
    [_commentLabel setCenter:CGPointMake(xStart + [_commentLabel frame].size.width / 2.0, yStart + BTN_SIZE / 2.0)];
    [self.view addSubview:_commentLabel];
    
    xStart += [_commentLabel frame].size.width + BTN_GAP;
    
    // Blogger label
    UILabel *bloggerLabel = [[UILabel alloc] initWithFrame:CGRectMake(xStart, yStart, 0, 0)];
    [bloggerLabel setText:[NSString stringWithFormat:@"来自 %@", [[_item blogger] name]]];
    [bloggerLabel setTextColor:[UIColor lightGrayColor]];
    [_commentLabel setFont:[UIFont systemFontOfSize:NAME_FONT_SIZE]];
    [bloggerLabel sizeToFit];
    [bloggerLabel setFrame:CGRectMake(WINDOW_WIDTH - [bloggerLabel frame].size.width - MARGIN_HORIZENTAL, HOME_POSTCELL_HEIGHT - [bloggerLabel frame].size.height - MARGIN_BOTTOM, [bloggerLabel frame].size.width, [bloggerLabel frame].size.height)];
    [self.view addSubview:bloggerLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - btn actions

- (void)likeBtnClicked:(UIButton *)sender
{
    if (_liking == NO)
    {
        _liking = YES;
        [_likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBtn_Focus"] forState:UIControlStateNormal];
        [_item setLikes:[_item likes] + 1];
    }
    else
    {
        _liking = NO;
        [_likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBtn_Normal"] forState:UIControlStateNormal];
        [_item setLikes:[_item likes] - 1];
    }
    
    [_likeLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)[_item likes]]];
}

- (void)commentBtnClicked:(UIButton *)sender
{
    NSLog(@"%s", __FUNCTION__);
}

@end
