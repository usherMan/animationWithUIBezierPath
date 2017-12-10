//
//  USCircleView.h
//  elm
//
//  Created by usher on 2017/7/10.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USCircleViewLayer.h"

@interface USCircleView : UIView<CAAnimationDelegate>
//进度
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic,strong)USCircleViewLayer *circleViewlayer;

@end
