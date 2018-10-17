//
//  MBProgressHUD+FYHUD.h
//  FYProgressHud
//
//  Created by wang on 2018/10/15.
//  Copyright © 2018 wang. All rights reserved.
//

#import "MBProgressHUD.h"


NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (FYHUD)


/**
 只显示图片
 */
+(void)fy_showOnlyImage:(NSString *)imageName;

/**
 只显示图片

 @param view 所显示的视图
 */
+(void)fy_showOnlyImage:(NSString *)imageName view:(nullable UIView *)view;

/**
 只显示纯文本

 @param message 显示的内容
 */
+(void)fy_showOnlyText:(NSString *)message;
/**
 只显示纯文本,默认一秒后消失

 @param message 显示的内容
 */
+(void)fy_showOnlyText:(NSString *)message view:(nullable UIView *)view;

/**
 只显示纯文本

 @param message 显示的内容
 @param view 显示的View
 @param time 显示多少时间后消失
 */
+(void)fy_showOnlyText:(NSString *)message view:(nullable UIView *)view time:(NSTimeInterval)time;

/**
 自定义帧动画,直接传入公共参数名称,例如iamge1,iamge2的image

 @param imageName 公共参数名称,例如iamge1,iamge2的image
 @param count 总共有多少帧
 @param view 添加到的view
 @param duration 一轮动画的时间
 */
+(void)fy_showLoadingImage:(NSArray *)imageName count:(NSInteger)count view:(nullable UIView *)view duration:(NSTimeInterval)duration;

/**
 自定义gif动画
 @param gifName gif的名称
 @param view 添加到的vIew
 @param duration 动画一轮的时间
 */
+(void)fy_showLoadingGif:(NSString *)gifName view:(nullable UIView *)view duration:(NSTimeInterval)duration;

/**
 自定义帧动画
 @param imageArr 帧动画数组
 @param view 显示的view
 @param duration 动画一次的时间
 */
+(void)fy_showLoadingArr:(NSArray *)imageArr view:(nullable UIView *)view duration:(NSTimeInterval)duration;

/**
 隐藏
 */
+(void)fy_hid;

/**
 隐藏
 @param view 父视图
 */
+(void)fy_hid:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END
