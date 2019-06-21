//
//  FYHUD.m
//  FYHUD
//
//  Created by wang on 2019/6/21.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYHUD.h"
#import "UIView+FYExtension.h"

// 是否是iPhoneX
// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define IPHONE_X \
({BOOL IPHONE_X = NO;\
if (@available(iOS 11.0, *)) {\
IPHONE_X = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(IPHONE_X);})

// 顶部区域
#define NavBarHight (IPHONE_X ? 88 : 64)
// 状态栏高度
#define StatusBarHeight (IPHONE_X ? 44.f : 20.f)
// tabBar高度
#define TabBarHeight (IPHONE_X ? 83 : 49.f)
//全面屏底部的手势高度
#define BottomLineHeight (IPHONE_X ? 34.f: 0.f)
#define kScreenw [UIScreen mainScreen].bounds.size.width //屏幕宽度
#define kScreenH [UIScreen mainScreen].bounds.size.height //屏幕高度

@implementation FYHUD

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenw ,self.frame.size.height)];
        coverView.backgroundColor = UIColor.whiteColor;
        coverView.alpha = 0.1;
        [self addSubview:coverView];
    }
    return self;
}

-(void)show {
    UIView *hud = [[UIView alloc] initWithFrame:CGRectMake((kScreenw - 50)/2, (self.frame.size.height)/2 - 100, 50, 50)];
    [self addSubview:hud];
    hud.layer.cornerRadius = 25;
    hud.backgroundColor = [UIColor whiteColor];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
    [self setupAnimationInLayer:hud.layer withSize:CGSizeMake(40, 40) tintColor:[UIColor lightGrayColor]];
}
-(void)showWithTitle:(NSString *)title {
    
    NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGFloat itemWidth = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil].size.width;
    UIView *hud = [[UIView alloc] initWithFrame:CGRectMake((kScreenw - itemWidth - 30)/2, (self.frame.size.height)/2 - 100, itemWidth + 30, 40)];
    hud.backgroundColor = [UIColor blackColor];
    hud.alpha = 0.7;
    [self addSubview:hud];
    hud.layer.cornerRadius = 5;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(hud.frame) + 15, CGRectGetMinY(hud.frame) + 13, itemWidth, 14)];
    [self addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
    
}
+(void)show {
    FYHUD *hud = [[FYHUD alloc] initWithFrame:CGRectMake(0, NavBarHight, kScreenw, kScreenH - NavBarHight)];
    [hud show];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
}
+(void)showWithTips:(NSString *)tips {
    FYHUD *hud = [[FYHUD alloc] initWithFrame:CGRectMake(0, NavBarHight, kScreenw, kScreenH - NavBarHight)];
    [hud showWithTitle:tips];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}
+(FYHUD *)getHUD {
    NSEnumerator *subviewsEnum = [[UIApplication sharedApplication].keyWindow.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            FYHUD *hud = (FYHUD *)subview;
            return hud;
        }
    }
    return nil;
}
+(void)dismiss {
    FYHUD *hud = [self getHUD];
    if (hud != nil) {
        [UIView animateWithDuration:0.3 animations:^{
             hud.alpha = 0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
    }
}


- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat circleSpacing = -2;
    CGFloat circleSize = (size.width - 4 * circleSpacing) / 5;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    CFTimeInterval duration = 1;
    NSTimeInterval beginTime = CACurrentMediaTime();
    NSArray *beginTimes = @[@0, @0.12, @0.24, @0.36, @0.48, @0.6, @0.72, @0.84];
    
    CAKeyframeAnimation *scaleAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0, @0.5, @1];
    scaleAnimation.values = @[@1, @0.4, @1];
    scaleAnimation.duration = duration;
    
    CAKeyframeAnimation *opacityAnimaton = [self createKeyframeAnimationWithKeyPath:@"opacity"];
    
    opacityAnimaton.keyTimes = @[@0, @0.5, @1];
    opacityAnimaton.values = @[@1, @0.3, @1];
    opacityAnimaton.duration = duration;
    
    
    CAAnimationGroup *animationGroup = [self createAnimationGroup];;
    animationGroup.animations = @[scaleAnimation, opacityAnimaton];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationGroup.duration = duration;
    animationGroup.repeatCount = HUGE;
    
    
    for (int i = 0; i < 8; i++) {
        CALayer *circle = [self circleLayer:(M_PI_4 * i) size:circleSize origin:CGPointMake(x, y) containerSize:size color:tintColor];
        animationGroup.beginTime = beginTime + [beginTimes[i] doubleValue];
        
        [layer addSublayer:circle];
        [circle addAnimation:animationGroup forKey:@"animation"];
    }
    
}


- (CALayer *)circleLayer:(CGFloat)angle size:(CGFloat)size origin:(CGPoint)origin containerSize:(CGSize)containerSize color:(UIColor *)color{
    CGFloat radius = containerSize.width/2;
    CALayer *circle = [self createLayerWith:CGSizeMake(size, size) color:color];
    CGRect frame = CGRectMake((origin.x + radius * (cos(angle) + 1) - size / 2), origin.y + radius * (sin(angle) + 1) - size / 2, size, size);
    circle.frame = frame;
    
    return circle;
}

- (CALayer *)createLayerWith:(CGSize)size color:(UIColor *)color{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path addArcWithCenter:CGPointMake(size.width / 2,size.height / 2) radius:(size.width / 2) startAngle:0 endAngle:2 * M_PI clockwise:NO];
    layer.fillColor = color.CGColor;
    layer.backgroundColor = nil;
    layer.path = path.CGPath;
    
    return layer;
}

- (CABasicAnimation *)createBasicAnimationWithKeyPath:(NSString *)keyPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.removedOnCompletion = NO;
    return animation;
}

- (CAKeyframeAnimation *)createKeyframeAnimationWithKeyPath:(NSString *)keyPath {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.removedOnCompletion = NO;
    return animation;
}

- (CAAnimationGroup *)createAnimationGroup {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.removedOnCompletion = NO;
    return animationGroup;
}

@end
