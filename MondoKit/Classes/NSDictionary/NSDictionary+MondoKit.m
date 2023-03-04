//
//  NSDictionary+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSDictionary+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSDictionary (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSPlaceholderDictionary_ = objc_getClass("__NSPlaceholderDictionary");
        
        mondo_swizzleInstanceMethodWithTarget(NSPlaceholderDictionary_,
                                              @selector(initWithObjects:forKeys:),
                                              @selector(mondo_initWithObjects:forKeys:));
        mondo_swizzleInstanceMethodWithTarget(NSPlaceholderDictionary_,
                                              @selector(initWithObjects:forKeys:count:),
                                              @selector(mondo_initWithObjects:forKeys:count:));
    });
}

- (instancetype)mondo_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys {
    if (objects.count == keys.count) {
        return [self mondo_initWithObjects:objects forKeys:keys];;
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数不对等"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:@(objects.count).stringValue forKey:@"objects.count"];
    [userInfo setObject:@(keys.count).stringValue forKey:@"keys.count"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return NSDictionary.dictionary;
}

- (instancetype)mondo_initWithObjects:(id  _Nonnull const[])objects forKeys:(id<NSCopying>  _Nonnull const[])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger count = 0;
    for (NSUInteger idx = 0; idx < cnt; idx ++) {
        id key = keys[idx];
        id obj = objects[idx];
        if (!key || !obj) {
            continue;
        }
        safeKeys[count] = key;
        safeObjects[count] = obj;
        count++;
    }
    
    if (count != cnt) {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数不对等"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(cnt).stringValue forKey:@"cnt"];
        [userInfo setObject:@(count).stringValue forKey:@"count"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
    
    return [self mondo_initWithObjects:safeObjects forKeys:safeKeys count:count];
}

@end
