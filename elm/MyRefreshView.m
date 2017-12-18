//
//  MyRefreshView.m
//  elm
//
//  Created by Usher Man on 2017/8/5.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "MyRefreshView.h"
#import "AnimationUtils.h"
#import "UIView+Layout.h"
//圆的高度
static float const USCircleHeight =30;
//起点
#define SHAPELAYER_START 0.25
//上下边缘间距
#define MARGIN 2
//动画持续时间
#define DURATION 0.5

typedef void (^USAnimationBlock)(BOOL finished);

@interface MyRefreshView()

//直线
@property (nonatomic,strong)CAShapeLayer *shapeLayer;
@property (nonatomic,strong)CAShapeLayer *shapeLayer2;
//圆弧
@property (nonatomic,strong)CAShapeLayer *circleShapeLayer;
@property (nonatomic,strong)CAShapeLayer *circleShapeLayer2;

@property (nonatomic, weak  ) UIScrollView * scrollView;
@property (nonatomic, assign) CGFloat progress;
//旋转中
@property (nonatomic, assign) BOOL rotating;

@end

@implementation MyRefreshView

- (instancetype)init
{
    if (self=[super initWithFrame:CGRectMake(0, -USCircleHeight, [UIScreen mainScreen].bounds.size.width, USCircleHeight)]) {
        [self initShapeLayers];
        self.backgroundColor=[UIColor grayColor];
    }
    return self;
}
- (void)initShapeLayers
{
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.center.x+USCircleHeight, self.center.y+USCircleHeight/2+USCircleHeight-MARGIN)];
    [path addLineToPoint:CGPointMake(self.center.x,self.center.y+(USCircleHeight/2)+USCircleHeight-MARGIN)];
    //下直线
    self.shapeLayer=[AnimationUtils returnCAShapeLayerWithFrame:CGRectZero strokeColor:[UIColor orangeColor].CGColor fillColor:[UIColor clearColor].CGColor lineWidth:2.f path:path.CGPath];
    self.shapeLayer.strokeStart=0.f;
    self.shapeLayer.strokeEnd=0.f;
    [self.layer addSublayer:self.shapeLayer];
    
    UIBezierPath *circlePath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(MARGIN, MARGIN, USCircleHeight-MARGIN*2, USCircleHeight-MARGIN*2)];
    //下半圆
    self.circleShapeLayer=[AnimationUtils returnCAShapeLayerWithFrame:CGRectMake(self.center.x-USCircleHeight/2, self.center.y-(USCircleHeight/2)+USCircleHeight, USCircleHeight, USCircleHeight) strokeColor:[UIColor orangeColor].CGColor fillColor:[UIColor clearColor].CGColor lineWidth:2.f path:circlePath.CGPath];
    self.circleShapeLayer.strokeStart=SHAPELAYER_START;
    self.circleShapeLayer.strokeEnd=SHAPELAYER_START;
    [self.layer addSublayer:self.circleShapeLayer];
    
    //    ---------------------
    
    UIBezierPath *path2=[UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(self.center.x-USCircleHeight, self.center.y-(USCircleHeight/2)+USCircleHeight+MARGIN)];
    [path2 addLineToPoint:CGPointMake(self.center.x, self.center.y-(USCircleHeight/2)+USCircleHeight+MARGIN)];
    //上直线
    self.shapeLayer2=[AnimationUtils returnCAShapeLayerWithFrame:CGRectZero strokeColor:[UIColor orangeColor].CGColor fillColor:[UIColor clearColor].CGColor lineWidth:2.f path:path2.CGPath];
    self.shapeLayer2.strokeStart=0.f;
    self.shapeLayer2.strokeEnd=0.f;
    [self.layer addSublayer:self.shapeLayer2];
    //上半圆
    self.circleShapeLayer2=[AnimationUtils returnCAShapeLayerWithFrame:self.circleShapeLayer.frame strokeColor:[UIColor orangeColor].CGColor fillColor:[UIColor clearColor].CGColor lineWidth:2.f path:circlePath.CGPath];
    self.circleShapeLayer2.strokeStart=SHAPELAYER_START;
    self.circleShapeLayer2.strokeEnd=SHAPELAYER_START;
    
    self.circleShapeLayer2.transform=CATransform3DMakeRotation(M_PI, 0, 0, 1);//顺时针旋转180度
    
    [self.layer addSublayer:self.circleShapeLayer2];
}

/*
 1.strokeEnd和strokeStart范围是[0,1]
 2.strokeStart指向strokeEnd的方向，要和path方向一致，如果和path方向相反，则绘制不了（这里指strokeStart=1，strokeEnd=0时）
 */
- (void)lineAnimaiionWithLineLayer:(CAShapeLayer *)shapeLayer circleLayer:(CAShapeLayer *)circleLayer progress:(CGFloat)progress
{
    //直线在[30,40]范围内变长，在[40,50]范围变短,
    if (progress >=USCircleHeight && progress <= USCircleHeight +10 && !self.rotating) {
        
        shapeLayer.strokeEnd = (progress - USCircleHeight) * 0.1;
    }else if(progress > USCircleHeight+10 && progress < USCircleHeight+20 && !self.rotating){
        
        shapeLayer.strokeStart = (progress - (USCircleHeight+10))*0.1;
        //圆弧开始变长时
        if (circleLayer.strokeEnd <SHAPELAYER_START +0.4f) {
            
            CGFloat tempStrokeEnd = (progress - (USCircleHeight+10))*0.08;
            //circleLayer.strokeEnd增加到0.68为最大值
            (tempStrokeEnd >=0.68) ? (circleLayer.strokeEnd =0.68) : (circleLayer.strokeEnd =tempStrokeEnd);
        }
    }else if ((progress >= USCircleHeight+19)){
        
        shapeLayer.strokeStart = 1.f;
        shapeLayer.strokeEnd   = 0.f;
        //防止快速拖动时没有绘制圆
        if (circleLayer.strokeEnd <SHAPELAYER_START +0.4f) {
            
            CGFloat tempStrokeEnd = (progress - (USCircleHeight+10))*0.08;
            //circleLayer.strokeEnd增加到0.68为最大值
            (tempStrokeEnd >=0.68) ? (circleLayer.strokeEnd =0.68) : (circleLayer.strokeEnd =tempStrokeEnd);
        }
        
        if (!self.rotating) {
            [self animationAllCircleShapeLayer:self.circleShapeLayer formValue:@(0) toValue:@(2*M_PI) forKey:@"circleShapeLayerAnim"];
            [self animationAllCircleShapeLayer:self.circleShapeLayer2 formValue:@(M_PI) toValue:@(3*M_PI) forKey:@"circleShapeLayer2Anim"];
        }
    }

    if (shapeLayer.strokeStart == shapeLayer.strokeEnd ) {
        shapeLayer.strokeEnd = 0;
    }

//    if (shapeLayer.strokeEnd >= 0.9 && shapeLayer.strokeStart <= 0.9) {
//        shapeLayer.strokeStart += 0.1;
//    }else if(shapeLayer.strokeStart == 0){
//        shapeLayer.strokeEnd += 0.1;
//    }
//
//    if (shapeLayer.strokeStart == shapeLayer.strokeEnd ) {
//        shapeLayer.strokeEnd = 0;
//    }
//    //直线开始剪短时
//    if (shapeLayer.strokeStart >0) {
//
//        if (circleLayer.strokeEnd <SHAPELAYER_START +0.4f) {
//
//            circleLayer.strokeEnd +=0.05;
//        }
//        if (circleLayer.strokeEnd >=(SHAPELAYER_START +0.4f) && shapeLayer.strokeStart >0.9 && (!self.rotating)) {
//            [self animationAllCircleShapeLayer:self.circleShapeLayer formValue:@(0) toValue:@(2*M_PI) forKey:@"circleShapeLayerAnim"];
//            [self animationAllCircleShapeLayer:self.circleShapeLayer2 formValue:@(M_PI) toValue:@(3*M_PI) forKey:@"circleShapeLayer2Anim"];
//        }
//    }

    NSLog(@"===%f===%f---%f---%f--",shapeLayer.strokeStart,shapeLayer.strokeEnd,circleLayer.strokeStart,circleLayer.strokeEnd);
}
//旋转动画
-(void)animationAllCircleShapeLayer:(CAShapeLayer *)circleShapeLayer formValue:(NSValue *)fromValue toValue:(NSValue *)toValue forKey:(NSString *)forKey
{
    CABasicAnimation *rotateAnimation=[AnimationUtils CABasicAnimationWithkeyPath:@"transform.rotation.z" fromValue:fromValue toValue:toValue];
    rotateAnimation.repeatCount=MAXFLOAT;
    rotateAnimation.duration=1.f;
    rotateAnimation.fillMode=kCAFillModeForwards;
    [circleShapeLayer addAnimation:rotateAnimation forKey:forKey];
    if (self.circleShapeLayer2 ==circleShapeLayer) {
        self.rotating = YES;
    }
}

- (void)stopAnimation
{
    [UIView animateWithDuration:DURATION animations:^{
        [self changeScrollViewCotentInsetsOfTop:0.f duration:0.f compleionBlock:nil];
    } completion:^(BOOL finished) {
        [self.circleShapeLayer removeAllAnimations];
        [self.circleShapeLayer2 removeAllAnimations];
        [self.layer removeAllAnimations];
        
        [self resetLayerStorkeValue];
    }];
}

- (void)resetLayerStorkeValue
{
    self.shapeLayer.strokeStart=0.f;
    self.shapeLayer.strokeEnd=0.f;
    self.circleShapeLayer.strokeEnd=SHAPELAYER_START;
    self.shapeLayer2.strokeStart=0.f;
    self.shapeLayer2.strokeEnd=0.f;
    self.circleShapeLayer2.strokeEnd=SHAPELAYER_START;
    
    self.rotating = NO;
}

#pragma mark - Override  当视图即将加入父视图时 / 当视图即将从父视图移除时调用
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        self.center = CGPointMake(self.scrollView.centerX, self.centerY);
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }else {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        self.progress = - self.scrollView.contentOffset.y;
    }
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (_progress >= 0) {
        
        //防止contentInset.top由0突然变到USCircleHeight，引起tabelview的contentOffset.y突变，tabelview明显的跳跃
        if (_progress < USCircleHeight) {
            
            self.y= -USCircleHeight;
            
            if (!self.rotating) {
                [self changeScrollViewCotentInsetsOfTop:0 duration:DURATION compleionBlock:^(BOOL finished){
                    [self resetLayerStorkeValue];
                }];
            }else
            {
                [self changeScrollViewCotentInsetsOfTop:_progress duration:DURATION compleionBlock:nil];
            }
        }else if(_progress >= USCircleHeight)
        {
            //当前view居中设置
            self.y = -((_progress - USCircleHeight)/2.0 + USCircleHeight);
            if (self.rotating) {
                if (!self.scrollView.dragging) {
                    [self changeScrollViewCotentInsetsOfTop:USCircleHeight duration:DURATION compleionBlock:nil];
                }
            }else
            {
                [self changeScrollViewCotentInsetsOfTop:0 duration:DURATION compleionBlock:nil];
            }
            [self startAnimation];
        }
    }
}
- (void)startAnimation
{
    [self lineAnimaiionWithLineLayer:self.shapeLayer circleLayer:self.circleShapeLayer progress:self.progress];
    [self lineAnimaiionWithLineLayer:self.shapeLayer2 circleLayer:self.circleShapeLayer2 progress:self.progress];
}

//改变contentInset.top
- (void)changeScrollViewCotentInsetsOfTop:(CGFloat)top duration:(CGFloat)duration compleionBlock:(USAnimationBlock)compleionBlock
{
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets insets =self.scrollView.contentInset;
        insets.top=top;
        self.scrollView.contentInset=insets;
    } completion:compleionBlock];
}
@end
