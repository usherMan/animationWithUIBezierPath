//
//  USCircleViewLayer.m
//  elm
//
//  Created by usher on 2017/7/11.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "USCircleViewLayer.h"

@implementation USCircleViewLayer

- (void)drawInContext:(CGContextRef)ctx {
    
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat lineWidth = 10.0;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - lineWidth / 2 startAngle:0.f endAngle:M_PI * 2 * self.progress clockwise:YES];
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.9, 1.0);//笔颜色
    CGContextSetLineWidth(ctx, 2);//线条宽度
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    
}

//- (void)setProgress:(CGFloat)progress {
//    _progress = progress;
//    [self setNeedsDisplay];
//}

//重载 needsDisplayForKey方法指定progress属性变化时进行重绘
+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (instancetype)initWithLayer:(USCircleViewLayer *)layer
{
    if (self=[super initWithLayer:layer]) {
        self.progress=layer.progress;
    }
    return self;
}

@end
