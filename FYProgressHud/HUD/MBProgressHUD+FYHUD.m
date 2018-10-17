//
//  MBProgressHUD+FYHUD.m
//  FYProgressHud
//
//  Created by wang on 2018/10/15.
//  Copyright © 2018 wang. All rights reserved.
//

#import "MBProgressHUD+FYHUD.h"
#import "GifArr.h"

@implementation MBProgressHUD (FYHUD)

//MARK:只显示文字
+(void)fy_showOnlyText:(NSString *)message {
    [self fy_showOnlyText:message view:nil time:1.5];
}

+(void)fy_showOnlyText:(NSString *)message view:(nullable UIView *)view {
    [self fy_showOnlyText:message view:view time:1.5];
}
+(void)fy_showOnlyText:(NSString *)message view:(nullable UIView *)view time:(NSTimeInterval)time{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

//MARK:显示帧动画gif
+(void)fy_showLoadingGif:(NSString *)gifName view:(nullable UIView *)view duration:(NSTimeInterval)duration {
    NSString *path=[[NSBundle mainBundle]pathForResource:gifName ofType:@"gif"];
    NSArray *gifImages=[GifArr praseGIFDataToImageArray:[NSData dataWithContentsOfFile:path]];
    [self fy_showLoadingArr:gifImages view:view duration:duration];
}

+(void)fy_showLoadingImage:(NSArray *)imageName count:(NSInteger)count view:(nullable UIView *)view duration:(NSTimeInterval)duration {
    NSMutableArray *arrm = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i= 0; i < count; i++) {
        NSString *image = [NSString stringWithFormat:@"%@%ld",imageName,i];
        [arrm addObject:image];
    }
    [self fy_showLoadingArr:arrm view:view duration:duration];
}

+(void)fy_showLoadingArr:(NSArray *)imageArr view:(nullable UIView *)view duration:(NSTimeInterval)duration {
    //如果VIEW为nil,就显示在window上
     if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80,80)];
    images.animationImages = imageArr;
    images.animationDuration = duration;
    images.animationRepeatCount = 0;
    [images startAnimating];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.customView = images;
}

//MARK:隐藏
+(void)fy_hid {
    [self fy_hid:nil];
}
+(void)fy_hid:(nullable UIView *)view {
    [[self progressHud:view] hideAnimated:YES];
}

+ (MBProgressHUD *)progressHud:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            MBProgressHUD *hudView = (MBProgressHUD *)subview;
            return hudView;
        }
    }
    return nil;
}


/**
 MARK:只显示图片
 */
+(void)fy_showOnlyImage:(NSString *)imageName view:(nullable UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50,50)];
    imageView.image = [UIImage imageNamed:imageName];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = imageView;
}

+(void)fy_showOnlyImage:(NSString *)imageName {
    [self fy_showOnlyImage:imageName view:nil];
}

@end
