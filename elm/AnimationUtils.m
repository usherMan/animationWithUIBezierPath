//
//  AnimationUtils.m
//  elm
//
//  Created by usher on 2017/7/18.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "AnimationUtils.h"
/*
 transform.scale = 比例转换
 transform.scale.x = 宽的比例转换
 transform.scale.y = 高的比例转换
 transform.rotation.z = 平面圖的旋转
 opacity = 透明度
 margin=边框间隔
 zPosition = 平面图的位置
 backgroundColor = 背景色
 cornerRadius = layer的角度
 borderWidth = 边框宽度
 contents = 内容
 bounds = 大小
 contentsRect = 内容矩形
 frame = 位置
 hidden = 隐藏
 mask = 标记
 maskToBounds
 position = 位置
 shadowOffset = 阴影偏移?
 shadowColor = 阴影颜色
 shadowRadius = 阴影角度
 */
@implementation AnimationUtils

+(CABasicAnimation *)CABasicAnimationWithkeyPath:(NSString*)keyPath fromValue:(NSValue *)fromValue toValue:(NSValue*)toValue
{
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:keyPath];
    basicAnimation.fromValue=fromValue;
    basicAnimation.toValue=toValue;
    basicAnimation.fillMode=kCAFillModeForwards;
    return basicAnimation;
}

+(CAAnimationGroup *)CAAnimationGroupWithAnimations:(NSArray *)animations duration:(double)duration removedOnCompletion:(BOOL)removedOnCompletion autoreverses:(BOOL)autoreverses
{
    CAAnimationGroup *animationGroup=[[CAAnimationGroup alloc] init];
    animationGroup.duration=duration;
    animationGroup.animations=animations;
    animationGroup.removedOnCompletion=removedOnCompletion;
    animationGroup.autoreverses=autoreverses;//动画结束时是否执行逆动画
    
    animationGroup.fillMode=kCAFillModeForwards;
    animationGroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//设置动画的速度变化
    
    return animationGroup;
}

/*
  1.CABasicAnimation可看做是最多只有2个关键帧的CAKeyframeAnimation;
  2.设置了path，那么values将被忽略，values和path同时只能有一个生效.
 */
+(CAKeyframeAnimation*)CAKeyframeAnimationWithKeyPath:(NSString*)keyPath values:(NSArray*)values path:(CGPathRef)path duration:(double)duration removedOnCompletion:(BOOL)removedOnCompletion autoreverses:(BOOL)autoreverses;
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = keyPath;
    animation.path=path;
    animation.values=values;
    animation.removedOnCompletion = removedOnCompletion;
    animation.autoreverses=autoreverses;//动画结束时是否执行逆动画
    animation.duration = duration;
    
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//设置动画的速度变化
    
    return animation;
}

+ (CAShapeLayer *)returnCAShapeLayerWithFrame:(CGRect)frame strokeColor:(CGColorRef)strokeColor fillColor:(CGColorRef)fillColor lineWidth:(CGFloat)lineWidth path:(CGPathRef)path
{
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.frame=frame;
    shapeLayer.strokeColor=strokeColor;
    shapeLayer.fillColor=fillColor;
    shapeLayer.path=path;
    shapeLayer.lineWidth=lineWidth;
    return shapeLayer;
}
@end
