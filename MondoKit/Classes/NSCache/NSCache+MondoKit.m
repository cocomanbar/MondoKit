//
//  NSCache+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSCache+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSCache (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSCache_ = objc_getClass("NSCache");
        
        mondo_swizzleInstanceMethodWithTarget(NSCache_,
                                              @selector(setObject:forKey:cost:),
                                              @selector(mondo_setObject:forKey:cost:));
        
    });
}

- (void)mondo_setObject:(id)obj forKey:(id)key cost:(NSUInteger)g{
    if (obj && key) {
        [self mondo_setObject:obj forKey:key cost:g];
    }else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为空"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:key ?: @"nil" forKey:@"key"];
        [userInfo setObject:obj ? NSStringFromClass([obj class]) : @"nil" forKey:@"obj"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

@end
