//
//  NSSet+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSSet+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSSet (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSSet_ = objc_getClass("NSSet");
        
        mondo_swizzleClassMethodWithTarget(NSSet_,
                                           @selector(setWithObject:),
                                           @selector(mondo_setWithObject:));
    });
}

+ (instancetype)mondo_setWithObject:(id)object{
    if (object){
        return [self mondo_setWithObject:object];
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为nil"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

@end
