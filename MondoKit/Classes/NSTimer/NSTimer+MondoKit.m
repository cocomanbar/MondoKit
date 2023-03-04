//
//  NSTimer+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/3/1.
//

#import "NSTimer+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"
#import "MondoTimerInfo.h"

/**
 *  解决的问题：
 *      1.循环引用
 *      2.置空定时器，防止方法一直在走
 */
@implementation NSTimer (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSTimer_ = objc_getClass("NSTimer");
        
        mondo_swizzleClassMethodWithTarget(NSTimer_,
                                           @selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:),
                                           @selector(mondo_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:));
        mondo_swizzleClassMethodWithTarget(NSTimer_,
                                           @selector(timerWithTimeInterval:target:selector:userInfo:repeats:),
                                           @selector(mondo_timerWithTimeInterval:target:selector:userInfo:repeats:));
        
    });
}

/**
 *  此方法创建timer自动加入runloop
 */
+ (NSTimer *)mondo_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats{
    if (!repeats) {
        return [self mondo_scheduledTimerWithTimeInterval:timeInterval target:aTarget selector:aSelector userInfo:userInfo repeats:repeats];
    }else{
        MondoTimerInfo *subtarget = [MondoTimerInfo mondo_scheduledTimerWithTimeInterval:timeInterval target:aTarget selector:aSelector userInfo:userInfo repeats:repeats];
        return [self mondo_scheduledTimerWithTimeInterval:timeInterval target:subtarget selector:NSSelectorFromString(kmondo_timer_intercept_sel) userInfo:userInfo repeats:repeats];
    }
}

/**
 *  此方法创建timer不会自动加入runloop
 */
+ (NSTimer *)mondo_timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats{
    if (!repeats) {
        return [self mondo_timerWithTimeInterval:timeInterval target:aTarget selector:aSelector userInfo:userInfo repeats:repeats];
    }else{
        MondoTimerInfo *subtarget = [MondoTimerInfo mondo_scheduledTimerWithTimeInterval:timeInterval target:aTarget selector:aSelector userInfo:userInfo repeats:repeats];
        return [self mondo_timerWithTimeInterval:timeInterval target:subtarget selector:NSSelectorFromString(kmondo_timer_intercept_sel) userInfo:userInfo repeats:repeats];
    }
}

@end
