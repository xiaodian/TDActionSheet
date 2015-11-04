//
//  TDActionSheet.m
//  TDActionSheet
//
//  Created by Su Jiandong on 15/11/4.
//  Copyright © 2015年 Su Jiandong. All rights reserved.
//

#import "TDActionSheet.h"
#define TDA_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define TDA_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
@interface TDActionSheet()
{
    NSArray *_titleArr;
    UIView *_buttonContentView;
    UIImageView *_backImageView;
    CGFloat _contentViewH;
    
    NSArray *_buttonTitles;
    NSArray *_buttonImages;
    NSArray *_buttonHighlightImages;
    
    int mode;
    
}
@property (nonatomic,strong)  TDActionBlock actionBlock;

@end

@implementation TDActionSheet

- (instancetype)initWithTitles:(NSArray *)titles callBack:(TDActionBlock )callBack
{
    self = [super init];
    if (self) {
        self.frame=[[UIScreen mainScreen] bounds];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)]];
        _titleArr=titles;
        if (!titles||!titles.count) {
            _titleArr=@[@"不要传空的好吗!"];
        }
        self.actionBlock=callBack;
        _contentViewH=(_titleArr.count+1)*45;
        [self configSubViews];
    }
    return self;
}

-(void)configSubViews
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *bgv = [[UIVisualEffectView alloc] initWithEffect:effect];
    bgv.frame = self.bounds;
    [self addSubview:bgv];
    
    _buttonContentView=[[UIView alloc]initWithFrame:CGRectMake(0, TDA_SCREEN_HEIGHT, TDA_SCREEN_WIDTH, _contentViewH)];
    [self addSubview:_buttonContentView];
    
    for (int i=0; i<_titleArr.count; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, i*45+(i%2==0?10:-10), TDA_SCREEN_WIDTH, 44);
        [button setTitle:_titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        button.titleLabel.font= [UIFont systemFontOfSize:17];
        button.tag=i+100;
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonContentView addSubview:button];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(20, 44.5+45*i, TDA_SCREEN_WIDTH-40, 0.5)];
        line.backgroundColor=[UIColor grayColor];
        [_buttonContentView addSubview:line];
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, _titleArr.count*45, TDA_SCREEN_WIDTH, 44);
    [button setTitle:@"取消" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.tag=_titleArr.count+100;
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContentView addSubview:button];
}

-(void)show
{
    if(!self.superview){
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
            if (window.windowLevel == UIWindowLevelNormal) {
                [window addSubview:self];
                break;
            }
    }
    [self buttonContentViewAnimation];
    [self buttonAnimation];
}

-(void)buttonContentViewAnimation
{
    [UIView animateWithDuration:0.7
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame=_buttonContentView.frame;
                         frame.origin.y=TDA_SCREEN_HEIGHT-_contentViewH;
                         _buttonContentView.frame=frame;
                     } completion:^(BOOL finished) {
                     }];
}

-(void)buttonAnimation
{
    for (int i=100; i<_titleArr.count+100; i++) {
        UIButton *btn=(UIButton *)[self viewWithTag:i];
        [UIView animateWithDuration:0.7
                              delay:0.2
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.2
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             CGRect frame=btn.frame;
                             frame.origin.y=45*(i-100);
                             btn.frame=frame;
                         } completion:^(BOOL finished) {
                         }];
    }
}

-(void)onButtonClick:(UIButton *)sender
{
    NSInteger tag = _titleArr.count+100;
    if (sender.tag==tag) {
        [self disMiss];
    }else{
        self.actionBlock(sender.tag-100);
        [self disMiss];
    }
}


-(void)disMiss
{
    for (UIView *view in _buttonContentView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

@end
