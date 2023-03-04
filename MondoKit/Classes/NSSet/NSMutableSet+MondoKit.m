//
//  NSMutableSet+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSMutableSet+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSMutableSet (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSMutableSet_ = objc_getClass("__NSSetM");
        
        mondo_swizzleInstanceMethodWithTarget(NSMutableSet_,
                                              @selector(addObject:),
                                              @selector(mondo_addObject:));
        mondo_swizzleInstanceMethodWithTarget(NSMutableSet_,
                                              @selector(removeObject:),
                                              @selector(mondo_removeObject:));
        
        
    });
}

- (void)mondo_addObject:(id)object{
    if (object) {
        [self mondo_addObject:object];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为nil"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_removeObject:(id)object{
    if (object) {
        [self mondo_removeObject:object];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为nil"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

@end
