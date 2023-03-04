//
//  NSMutableDictionary+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSMutableDictionary+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSMutableDictionary (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSDictionaryM_ = objc_getClass("__NSDictionaryM");
        
        mondo_swizzleInstanceMethodWithTarget(NSDictionaryM_,
                                              @selector(setObject:forKey:),
                                              @selector(mondo_setObject:forKey:));
        mondo_swizzleInstanceMethodWithTarget(NSDictionaryM_,
                                              @selector(removeObjectForKey:),
                                              @selector(mondo_removeObjectForKey:));
        
    });
}

- (void)mondo_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject && aKey) {
        [self mondo_setObject:anObject forKey:aKey];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为空"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:anObject ? NSStringFromClass([anObject class]) : @"nil" forKey:@"anObject"];
        [userInfo setObject:aKey ?: @"nil" forKey:@"aKey"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_removeObjectForKey:(id)aKey{
    if (aKey) {
        [self mondo_removeObjectForKey:aKey];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为空"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}


@end
