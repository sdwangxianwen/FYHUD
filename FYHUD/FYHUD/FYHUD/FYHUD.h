//
//  FYHUD.h
//  FYHUD
//
//  Created by wang on 2019/6/21.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYHUD : UIView

+(void)show;
+(void)showWithTips:(NSString *)tips;
+(void)dismiss;

@end

NS_ASSUME_NONNULL_END
