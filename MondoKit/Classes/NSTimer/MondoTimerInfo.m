//
//  MondoTimerInfo.m
//  MondoKit
//
//  Created by tanxl on 2023/3/1.
//

#import "MondoTimerInfo.h"
#import "MondoService.h"

NSString *const kmondo_timer_intercept_sel = @"mondo_timer_intercept_sel:";

@interface MondoTimerInfo ()
{
    __weak id _target;
    id _userInfo;
    BOOL _repeats;
    SEL _selector;
    Class _targetClass;
    NSTimeInterval _timeInterval;
}

@end

@implementation MondoTimerInfo

+ (instancetype)mondo_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                               target:(id)target
                                             selector:(SEL)selector
                                             userInfo:(id)userInfo
                                              repeats:(BOOL)repeats
{
    MondoTimerInfo *timer_info = [[MondoTimerInfo alloc] init];
    timer_info->_timeInterval = timeInterval;
    timer_info->_target = target;               /// 1.解决循环引用问题
    timer_info->_selector = selector;
    timer_info->_userInfo = userInfo;
    timer_info->_repeats = repeats;
    timer_info->_targetClass = [target class];
    return timer_info;
}

/// forward sel
- (void)mondo_timer_intercept_sel:(NSTimer *)timer{
    
    if (_target) {
        _Pragma("clang diagnostic push");
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"");
        if ([_target respondsToSelector:_selector]) {
            [_target performSelector:_selector withObject:timer];
        }
        _Pragma("clang diagnostic pop");
    }else{
        
        /// 上报
        NSString *name = @"Timer";
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_selector), @"定时器销毁后，方法依然在走."];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromSelector(_selector) forKey:@"_selector"];
        [userInfo setObject:NSStringFromClass(_targetClass) forKey:@"_targetClass"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
        
        /// 2.解决target释放后定时器任务一直走的问题
        if ([timer isKindOfClass:NSTimer.class]) {
            if ([timer isValid]) {
                [timer invalidate];
            }
        }
    }
}

@end
