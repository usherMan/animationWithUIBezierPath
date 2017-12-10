//
//  UIScrollView+USRefreshView.h
//  elm
//
//  Created by Usher Man on 2017/8/8.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRefreshView.h"

@interface UIScrollView (USRefreshView)

@property (nonatomic, weak, readonly) MyRefreshView * header;

- (void)addRefreshHeaderWithHandle:(void (^)())handle;

@end
