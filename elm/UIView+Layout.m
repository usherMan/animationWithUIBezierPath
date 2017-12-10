//
//  UIView+Layout.m
//  elm
//
//  Created by Usher Man on 2017/8/9.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (float)top
{
    return self.frame.origin.y;
}
- (void)setTop:(float)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (float)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(float)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}


- (float)left
{
    return self.frame.origin.x;
}
- (void)setLeft:(float)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}


- (float)right
{
    return self.frame.origin.y + self.frame.size.width;
}
- (void)setRight:(float)right{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}



- (float)x
{
    return self.frame.origin.x;
}
- (void)setX:(float)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (float)y
{
    return self.frame.origin.y;
}
- (void)setY:(float)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (float)widht
{
    return self.frame.size.width;
}
- (void)setWidht:(float)widht
{
    CGRect frame = self.frame;
    frame.size.width = widht;
    self.frame = frame;
}
- (float)heiht
{
    return self.frame.size.height;
}
- (void)setHeiht:(float)heiht
{
    CGRect frame = self.frame;
    frame.size.height= heiht;
    self.frame = frame;
}

- (float)centerX
{
    return self.center.x;
}
- (void)setCenterX:(float)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (float)centerY
{
    return self.center.y;
}
- (void)setCenterY:(float)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGSize)size
{
    return self.frame.size;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
}

- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin= origin;
    self.frame = frame;
    
}
@end
