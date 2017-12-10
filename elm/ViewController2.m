//
//  ViewController2.m
//  elm
//
//  Created by usher on 2017/7/11.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "ViewController2.h"

#import "MyCircleView.h"
#import "USCircleView.h"
#import "AnimationUtils.h"
#import "MyRefreshView.h"

#define SHAPELAYER_1_START 0.25f

@interface ViewController2 ()<CAAnimationDelegate>

@property (nonatomic,strong)CAShapeLayer *shapeLayer;
@property (nonatomic,strong)CAShapeLayer *shapeLayer2;

@property (nonatomic,strong)CAShapeLayer *circleShapeLayer;
@property (nonatomic,strong)CAShapeLayer *circleShapeLayer2;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic,assign)CGFloat angle;
//记录圆弧strokeEnd递增，strokeStart不变的
@property (nonatomic,assign)BOOL isFirst;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[[MyRefreshView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)]];
    
    [self test5];
    
    MyCircleView *myView = [[MyCircleView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    myView.backgroundColor=[UIColor whiteColor];
    myView.numberPercent=0.45;
//    [self.view addSubview:myView];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.shapeLayer removeFromSuperlayer];
//    [self test2];
}
#pragma mark 沿着一个贝塞尔曲线对图层做动画
- (void)test1
{
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"1.png"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    animation.removedOnCompletion=NO;
    [shipLayer addAnimation:animation forKey:nil];
}

#pragma mark 动态直线
- (void)test2
{
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];//起点
    [path addLineToPoint:CGPointMake(50, 50)];//终点
    
    self.shapeLayer=self.shapeLayer=[AnimationUtils returnCAShapeLayerWithFrame:CGRectZero strokeColor:[UIColor orangeColor].CGColor fillColor:[UIColor purpleColor].CGColor lineWidth:3.f path:path.CGPath];;
    
    [self.view.layer addSublayer:self.shapeLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 3;
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    
    [self.shapeLayer addAnimation:animation forKey:@"strokeEnd"];
}

#pragma mark 执行一个缩放和平移的动画组
- (void)test3
{
    self.imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    self.imageView.frame=CGRectMake(50, 50, 70, 70);
    [self.view addSubview:self.imageView];
    
    //缩放
    CABasicAnimation *zoomAminmation=[AnimationUtils CABasicAnimationWithkeyPath:@"transform.scale" fromValue:@(1.0) toValue:@(0.3f)];
    
    //位移(视图中心)
    CABasicAnimation *moveAnimation=[AnimationUtils CABasicAnimationWithkeyPath:@"position" fromValue:[NSValue valueWithCGPoint:CGPointMake(self.imageView.frame.origin.x + self.imageView.frame.size.width /2.0, self.imageView.frame.origin.y +self.imageView.frame.size.height /2.0)] toValue:[NSValue valueWithCGPoint:CGPointMake(300, 400)]];
    
    //动画组
    CAAnimationGroup *animationGroup=[AnimationUtils CAAnimationGroupWithAnimations:[NSArray arrayWithObjects:zoomAminmation,moveAnimation, nil] duration:3.0 removedOnCompletion:NO autoreverses:NO];
    animationGroup.delegate=self;
    
    [self.imageView.layer addAnimation:animationGroup forKey:@"zoom-moveAnim"];
}
#pragma mark 关键帧动画
- (void)test4
{
    self.imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    self.imageView.frame=CGRectMake(50, 50, 70, 70);
    [self.view addSubview:self.imageView];
 
//    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(200, 100)];
//    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
//    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
//    CAKeyframeAnimation *animation = [AnimationUtils CAKeyframeAnimationWithKeyPath:@"position" values:@[value1,value2,value3,value4,value5] path:nil duration:4.0f removedOnCompletion:NO autoreverses:NO];

    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAKeyframeAnimation *animation=[AnimationUtils CAKeyframeAnimationWithKeyPath:@"position" values:nil path:bezierPath.CGPath duration:4.0f removedOnCompletion:NO autoreverses:NO];
    animation.repeatCount=3;
    animation.delegate=self;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
}

#pragma mark 锚点的使用(可以改变视图的中心)
- (void)test5
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
   
    self.imageView=[[UIImageView alloc] init];
    self.imageView.frame=CGRectMake(150, 150, 70, 200);
    self.imageView.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:self.imageView];
    //角度初始化为1
    self.angle=1.f;
    
    self.imageView.layer.anchorPoint=CGPointMake(0.5f, 0.9f);
}

- (void)tick
{
    CGFloat secondAngle = (self.angle/60) * M_PI * 2.0;//秒针旋转角度

    self.imageView.transform = CGAffineTransformMakeRotation(secondAngle);

    if (self.angle<60) {
        self.angle+=1;
    }else
    {
        self.angle=1;
    }

}
//动画结束时移除view，否则它会一直存在于内存中，直到图层被销毁
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.imageView removeFromSuperview];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer=nil;
}
@end
