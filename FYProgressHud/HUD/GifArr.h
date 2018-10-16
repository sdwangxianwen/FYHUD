//
//  GifArr.h
//  FYNetWorkHelper
//
//  Created by wang on 2018/10/15.
//  Copyright © 2018 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GifArr : NSObject
+(NSMutableArray *)praseGIFDataToImageArray:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
