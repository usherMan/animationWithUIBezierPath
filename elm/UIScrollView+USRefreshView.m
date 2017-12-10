//
//  UIScrollView+USRefreshView.m
//  elm
//
//  Created by Usher Man on 2017/8/8.
//  Copyright © 2017年 Usher Man. All rights reserved.
//

#import "UIScrollView+USRefreshView.h"
#import <objc/runtime.h>

@implementation UIScrollView (USRefreshView)

- (void)addRefreshHeaderWithHandle:(void (^)())handle
{
    MyRefreshView *header =[[MyRefreshView alloc] init];
    header.handle=handle;
    self.header=header;
    [self insertSubview:header atIndex:0];//设置在UITableViewWrapperview底下
    
}
#pragma mark - Associate
- (void)setHeader:(MyRefreshView *)header {
    objc_setAssociatedObject(self, @selector(header), header, OBJC_ASSOCIATION_ASSIGN);
}

- (MyRefreshView *)header {
    return objc_getAssociatedObject(self, @selector(header));
}

#pragma mark - Swizzle
+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method swizzleMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"us_dealloc"));
    method_exchangeImplementations(originalMethod, swizzleMethod);
}

- (void)us_dealloc {
    self.header = nil;
    [self us_dealloc];
}
@end
