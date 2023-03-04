//
//  NSObject+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSObject+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@interface MondoUnrecognizedSel : NSObject

@end

@implementation NSObject (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSObject_ = objc_getClass("NSObject");
        
        mondo_swizzleInstanceMethodWithTarget(NSObject_,
                                              @selector(forwardingTargetForSelector:),
                                              @selector(mondo_forwardingTargetForSelector:));
        
        mondo_swizzleInstanceMethodWithTarget(NSObject_,
                                              @selector(setValue:forUndefinedKey:),
                                              @selector(mondo_setValue:forUndefinedKey:));
        
    });
}

- (void)mondo_setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"UndefinedKey"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:key?:@"nil" forKey:@"key"];
    [userInfo setObject:value ? NSStringFromClass([value class]) : @"nil" forKey:@"value"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
}

- (id)mondo_forwardingTargetForSelector:(SEL)selector{

    if (![self overideForwardingMethods]) {
        
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"forwardingTargetForSelector"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromSelector(selector) forKey:@"selector"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
        
        return [[MondoUnrecognizedSel alloc] init];
    }
    return [self mondo_forwardingTargetForSelector:selector];
}

- (BOOL)overideForwardingMethods{
    BOOL overide = NO;
    overide = (class_getMethodImplementation([NSObject class], @selector(forwardInvocation:)) != class_getMethodImplementation([self class], @selector(forwardInvocation:))) ||
    (class_getMethodImplementation([NSObject class], @selector(forwardingTargetForSelector:)) != class_getMethodImplementation([self class], @selector(forwardingTargetForSelector:)));
    return overide;
}

@end

@implementation MondoUnrecognizedSel

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)_private_mondoDynamicAddMethodIMP, "v@:@");
    return YES;
}

id _private_mondoDynamicAddMethodIMP(id self, SEL _cmd) {
    return 0;
}

@end
