//
//  MyRefreshView.h
//  elm
//
//  Created by Usher Man on 2017/8/5.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRefreshView : UIView

@property (nonatomic, copy) void(^handle)();

- (void)stopAnimation;
@end
