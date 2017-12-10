//
//  AnimationUtils.h
//  elm
//
//  Created by usher on 2017/7/18.
//  Copyright © 2017年 Usher Man. All rights reserved.
//  动画工具类

#import <UIKit/UIKit.h>

/*
 removedOnCompletion = NO;
 fillMode = kCAFillModeForwards;能防止动画结束后回到初始状态
 */
@interface AnimationUtils : NSObject

+(CABasicAnimation *)CABasicAnimationWithkeyPath:(NSString*)keyPath fromValue:(NSValue *)fromValue toValue:(NSValue*)toValue;

+(CAAnimationGroup *)CAAnimationGroupWithAnimations:(NSArray *)animations duration:(double)duration removedOnCompletion:(BOOL)removedOnCompletion autoreverses:(BOOL)autoreverses;

+(CAKeyframeAnimation*)CAKeyframeAnimationWithKeyPath:(NSString*)keyPath values:(NSArray*)values path:(CGPathRef)path duration:(double)duration removedOnCompletion:(BOOL)removedOnCompletion autoreverses:(BOOL)autoreverses;

+ (CAShapeLayer *)returnCAShapeLayerWithFrame:(CGRect)frame strokeColor:(CGColorRef)strokeColor fillColor:(CGColorRef)fillColor lineWidth:(CGFloat)lineWidth path:(CGPathRef)path;

@end
