//
//  UIView+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "UIView+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation UIView (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class UIView_ = objc_getClass("UIView");
        
        mondo_swizzleInstanceMethodWithTarget(UIView_,
                                              @selector(setNeedsLayout),
                                              @selector(mondo_setNeedsLayout));
        mondo_swizzleInstanceMethodWithTarget(UIView_,
                                              @selector(layoutIfNeeded),
                                              @selector(mondo_layoutIfNeeded));
        mondo_swizzleInstanceMethodWithTarget(UIView_,
                                              @selector(layoutSubviews),
                                              @selector(mondo_layoutSubviews));
        mondo_swizzleInstanceMethodWithTarget(UIView_,
                                              @selector(setNeedsDisplay),
                                              @selector(mondo_setNeedsDisplay));
        mondo_swizzleInstanceMethodWithTarget(UIView_,
                                              @selector(setNeedsDisplayInRect:),
                                              @selector(mondo_setNeedsDisplayInRect:));
        mondo_swizzleInstanceMethodWithTarget(UIView_,
                                              @selector(setNeedsUpdateConstraints),
                                              @selector(mondo_setNeedsUpdateConstraints));
        mondo_swizzleInstanceMethodWithTarget(UIView_,
                                              @selector(addSubview:),
                                              @selector(mondo_addSubview:));
        
    });
}

- (void)mondo_setNeedsUpdateConstraints {
    if ([NSThread isMainThread]) {
        [self mondo_setNeedsUpdateConstraints];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mondo_setNeedsUpdateConstraints];
            
            NSString *name = NSStringFromClass(self.class);
            NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"主线程错误操作ui"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
            [MondoService dealException:exception];
        });
    }
}

- (void)mondo_layoutSubviews {
    if ([NSThread isMainThread]) {
        [self mondo_layoutSubviews];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mondo_layoutSubviews];
            
            NSString *name = NSStringFromClass(self.class);
            NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"主线程错误操作ui"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
            [MondoService dealException:exception];
        });
    }
}

- (void)mondo_layoutIfNeeded {
    if ([NSThread isMainThread]) {
        [self mondo_layoutIfNeeded];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mondo_layoutIfNeeded];
            
            NSString *name = NSStringFromClass(self.class);
            NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"主线程错误操作ui"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
            [MondoService dealException:exception];
        });
    }
}

- (void)mondo_addSubview:(UIView *)view{
    if ([view isEqual:self]) {
        
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"View不能再次添加自己"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
        return;
    }
    [self mondo_addSubview:view];
}

- (void)mondo_setNeedsLayout{
    if ([NSThread isMainThread]) {
        [self mondo_setNeedsLayout];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mondo_setNeedsLayout];
            
            NSString *name = NSStringFromClass(self.class);
            NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"主线程错误操作ui"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
            [MondoService dealException:exception];
        });
    }
}

- (void)mondo_setNeedsDisplay{
    if ([NSThread isMainThread]) {
        [self mondo_setNeedsDisplay];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mondo_setNeedsDisplay];
            
            NSString *name = NSStringFromClass(self.class);
            NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"主线程错误操作ui"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
            [MondoService dealException:exception];
        });
    }
}

- (void)mondo_setNeedsDisplayInRect:(CGRect)rect{
    if ([NSThread isMainThread]) {
        [self mondo_setNeedsDisplayInRect:rect];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mondo_setNeedsDisplayInRect:rect];
            
            NSString *name = NSStringFromClass(self.class);
            NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"主线程错误操作ui"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
            [MondoService dealException:exception];
        });
    }
}

@end
