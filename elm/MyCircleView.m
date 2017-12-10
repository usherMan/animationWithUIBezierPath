//
//  MyCircleView.m
//  elm
//
//  Created by Usher Man on 16/9/12.
//  Copyright © 2016年 Usher Man. All rights reserved.
//

#import "MyCircleView.h"
/*
 
 CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, // 圆心(x,y)
 CGFloat radius, // 半径
 CGFloat startAngle, CGFloat endAngle, // 开始、结束弧度
 int clockwise // 绘制方向，YES:逆时针;NO:顺时针
 )
 
 用法心得：
 1. 弧度
 中心点右侧 弧度为 0
 中心点下方 弧度为 M_PI_2
 中心点左侧 弧度为 M_PI
 中心点上方 弧度为 -M_PI_2
 
 2. 绘制x弧度圆
 所谓x弧度圆，就是不满2π的圆弧。
 比如 想画一个 缺口朝下&amp;缺口弧度30度 的x弧度圆
 选择逆时针画法：
 startAngle = M_PI_2 - (15/180*M_PI);
 endAngle = M_PI_2 + (diff/180*M_PI);
 clockwise = YES;
 选择顺时针画法:
 startAngle = M_PI_2 + (15/180*M_PI);
 endAngle = M_PI_2 - (diff/180*M_PI);
 clockwise = NO;
 
 */
@implementation MyCircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/

- (void)drawRect:(CGRect)rect {

    CGRect frame = self.bounds;
    /*画填充圆
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
        
    //边框圆(紫色)
    CGContextSetLineWidth(context, 1);
    CGContextAddArc(context, frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2, frame.size.height/2-2, 0, 2*M_PI, 0);
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.9, 1.0);//笔颜色
    CGContextDrawPath(context, kCGPathStroke);
    
    //边框圆（咖啡色）
    CGContextSetLineWidth(context, 7);
    CGFloat startAngle = -(90*M_PI/180);
    CGFloat endAngle = 0.0;
    CGFloat startAngle1 = 0.0;
    CGFloat endAngle1 = 0.0;
    if( (_numberPercent)<1 && _numberPercent>=0.75  ){
        
        endAngle = - ((1-_numberPercent)*M_PI*2 + M_PI_2);
    }else if(_numberPercent<0.75 && _numberPercent>0.5){
        
        endAngle = M_PI-(1-_numberPercent)*M_PI*2+M_PI_2;
    }else if(_numberPercent<=0.5 && _numberPercent>=0.25){
        
        endAngle =(2*M_PI*3)/4 -(1-_numberPercent)*M_PI*2 ;
    }else if((_numberPercent<0.25 && (_numberPercent)>0)){
        
        endAngle = - (M_PI_2- _numberPercent*M_PI*2);
    }
    startAngle1 = endAngle;
    endAngle1 = -(90*M_PI/180);
    
    if (_numberPercent == 0){
        startAngle = 0.0;
        endAngle = 2*M_PI;
        startAngle1 = endAngle1;
    }else if (_numberPercent == 1){
        startAngle1 = 0.0;
        endAngle1 = 2*M_PI;
        startAngle = endAngle;
    }
    CGFloat clockwise = 1;//逆时针
    CGContextAddArc(context, frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2, frame.size.height/2-14, startAngle, endAngle, clockwise);
    CGContextSetRGBStrokeColor(context, 0.5, 0.4, 0.2, 1.0);//笔颜色
    CGContextDrawPath(context, kCGPathStroke);
    
    //边框圆（紫色）
    CGContextSetLineWidth(context, 7);
    CGFloat clockwise1 = 1;//逆时针
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddArc(context, frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2, frame.size.height/2-14, startAngle1, endAngle1, clockwise1);
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.9, 1.0);//笔颜色
    CGContextDrawPath(context, kCGPathStroke);
    
    //画一个圆点
    /*画填充圆
     */
    [[UIColor clearColor] set];
    CGContextFillRect(context, rect);
    
    CGContextAddEllipseInRect(context, CGRectMake(frame.origin.x+frame.size.width/2, 0, 5, 5));//实心圆
    [[UIColor orangeColor] set];
    CGContextFillPath(context);
    
    // 写文字
    CGContextSetLineWidth(context, 5.0);
    CGContextSetRGBFillColor (context,  0.5, 0.5, 0.9, 1.0);
    NSDictionary *attributes=@{NSFontAttributeName:[UIFont systemFontOfSize:29.0],NSForegroundColorAttributeName:[UIColor colorWithRed:0.502 green:0.514 blue:0.890 alpha:1.00]};
    
    NSString *stringPercent=[self stringWithFloat:_numberPercent];
    CGSize size=[self sizeOfString:stringPercent withTotalSize:CGSizeMake(self.frame.size.width, MAXFLOAT) withFont:29.0];
    
    [stringPercent drawAtPoint:CGPointMake(self.frame.size.width/2-size.width/2, self.frame.size.width/2-size.height/2) withAttributes:attributes];
}

//计算文字的宽高
- (CGSize)sizeOfString:(NSString*)string withTotalSize:(CGSize)totalSize withFont:(CGFloat)font
{
    CGRect rect = [string boundingRectWithSize:totalSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName,nil] context:nil];
    
    return  rect.size ;
}

- (NSString*)stringWithFloat:(CGFloat)numberPercent
{
    
    return [[NSString stringWithFormat:@"%.1f",numberPercent*100] stringByAppendingString:@"%"];
}

@end
