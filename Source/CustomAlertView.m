//
//  CustomAlertView.m
//  AlertView
//
//  Created by 官深宝 on 2018/9/20.
//  Copyright © 2018年 Angie. All rights reserved.
//

#import "CustomAlertView.h"

@interface CustomAlertView ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation CustomAlertView

static CustomAlertView *customAlertView = nil;

// .h 中声明出单例接口
// 这里的 alloc 会调用下面的 alloc 方法

+ (instancetype)shareCustomAlertView {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customAlertView = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01)];
        [self setupCustomAlertView];
    });
    
    return customAlertView;
}

// 这个方法服务于 alloc ，不论外界调用多少次 alloc ，分配的空间地址都是一个
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customAlertView = [super allocWithZone:zone];
        [self setupCustomAlertView];
    });
    return customAlertView;
}
- (id)copyWithZone:(NSZone *)zone{
    return customAlertView;
}

+ (void)setupCustomAlertView {
    customAlertView.clipsToBounds = YES;
    customAlertView.backgroundColor = [UIColor whiteColor];
    [customAlertView addSubview:customAlertView.logoImageView];
    [customAlertView addSubview:customAlertView.titleLabel];
    [customAlertView addSubview:customAlertView.timeLabel];
    [customAlertView addSubview:customAlertView.contentLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:customAlertView action:@selector(clickHidden)];
    [customAlertView addGestureRecognizer:tap];
}


+ (void)showAlertViewWithTitle:(NSString *)title content:(NSString *)content avatar:(NSString *)avatar time:(NSString *)time duration:(CGFloat )duration success:(void (^)(void))success {
    
    CustomAlertView *customAlertView = [CustomAlertView shareCustomAlertView];
    UIImage *logoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatar]]];
    customAlertView.logoImageView.image = logoImage;
    customAlertView.titleLabel.text = title;
    customAlertView.timeLabel.text = time;
    customAlertView.contentLabel.text = content;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:customAlertView];
    
    [UIView animateWithDuration:0.5 animations:^{
        customAlertView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 90);
    } completion:^(BOOL finished) {
        [self addTimingWithView:customAlertView duration:duration];
    }];
}

+ (void)addTimingWithView:(CustomAlertView *)customAlertView duration:(CGFloat )duration {
    
    __block int timeout = duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    customAlertView.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(customAlertView.timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(customAlertView.timer, ^{
        if (timeout <= 0) {
            /// 倒计时结束
            dispatch_source_cancel(customAlertView.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [customAlertView clickHidden];
            });
        }
        timeout--;
    });
    dispatch_resume(customAlertView.timer);
}

- (void)clickHidden {
    [UIView animateWithDuration:0.5 animations:^{
        customAlertView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01);
    } completion:^(BOOL finished) {
        [customAlertView removeFromSuperview];
    }];
}

#pragma  mark - Lazy

- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 22, 20, 20)];
    }
    return _logoImageView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 22, 200, 20)];
        _titleLabel.textColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 92, 22, 80, 20)];
        _timeLabel.textColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 50,[UIScreen mainScreen].bounds.size.width - 24 , 34)];
        _contentLabel.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}
@end
