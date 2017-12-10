//
//  ViewController.m
//  elm
//
//  Created by Usher Man on 16/9/6.
//  Copyright © 2016年 Usher Man. All rights reserved.
//

#import "ViewController.h"
#import "USCircleViewLayer.h"
#import "USCircleView.h"


@interface ViewController ()
@property (nonatomic,retain) CAShapeLayer *shapeLayer;
@property (nonatomic,retain) NSTimer *timer;
@property (strong,nonatomic)USCircleView *circleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
//    [self test1];
//    [self test2];
    
    [self test3];
    
  
}

#pragma mark 转动的圆
- (void)test1
{
    [self circleBezierPath];
    //用定时器模拟数值输入的情况
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
              
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
}
#pragma mark 转动的圆
- (void)test2
{
    self.circleView= [[USCircleView alloc] initWithFrame:CGRectMake(50, 50, 200, 300)];
    self.circleView.progress=0.0;
    [self.view addSubview:self.circleView];
    
    //用定时器模拟数值输入的情况
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(circleAnimationTypeTwo)
                                            userInfo:nil
                                             repeats:YES];
}
#pragma mark 转动的圆
//containerView view的内嵌圆（椭圆）
-(void)test3
{
    UIView *containerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    containerView.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:containerView];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = containerView.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:containerView.bounds];//内嵌圆（椭圆）
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [containerView.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    pathAnima.repeatCount=3.f;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

-(void)circleBezierPath
{
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 0, 150, 150);
    self.shapeLayer.position = self.view.center;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 2.0f;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 150, 150)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:self.shapeLayer];
}

- (void)circleAnimationTypeOne
{
    if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1) {
        self.shapeLayer.strokeStart += 0.1;
    }else if(self.shapeLayer.strokeStart == 0){
        self.shapeLayer.strokeEnd += 0.1;
    }
    //循环条件
    if (self.shapeLayer.strokeEnd == 0) {
        self.shapeLayer.strokeStart = 0;
        
    }
    
    if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
        self.shapeLayer.strokeEnd = 0;
    }
    
    NSLog(@"===%f===%f",self.shapeLayer.strokeEnd,self.shapeLayer.strokeStart);
}

- (void)circleAnimationTypeTwo
{
    if (self.circleView.progress >= 0 && self.circleView.progress<1) {
        self.circleView.progress +=0.03;
    }else if(self.circleView.progress>=1)
    {
        self.circleView.progress=0.0;
    }
    NSLog(@"-------%f",self.circleView.progress);
}
@end
