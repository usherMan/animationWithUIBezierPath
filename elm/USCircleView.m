//
//  USCircleView.m
//  elm
//
//  Created by usher on 2017/7/10.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "USCircleView.h"

@implementation USCircleView
/*
 1.变化幅度小，变化速度快的情景，选用setNeedsDisplay进行重绘就可以满足需求。
 2.变化幅度大、变化速度慢的情景，选用给属性添加CA动画来满足需求。
 
 　　应用场景：下载进度的变化、数字变化的效果
 
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.circleViewlayer = [USCircleViewLayer layer];
        self.circleViewlayer.frame = self.bounds;        //像素大小比例
        self.circleViewlayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:self.circleViewlayer];
    }
    return  self;
}

//- (void)setProgress:(CGFloat)progress {
//    self.circleViewlayer.progress=progress;
//    _progress = progress;
//}

- (void)setProgress:(CGFloat)progress {
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"progress"];
    double duration = fabs(progress - _progress);
    if (duration>0.5) {
        duration =0.5;//动画时间不能大于定时器刷新时间，每次刷新时间都设置为0.4
    }
    NSLog(@"######%f",duration);
    ani.duration = 0.1;
    ani.toValue = @(progress);
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    ani.delegate = self;
    [self.circleViewlayer addAnimation:ani forKey:@"progressAni"];
    _progress = progress;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.circleViewlayer.progress=self.progress;
}
@end
