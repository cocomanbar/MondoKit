//
//  NSMutableOrderedSet+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSMutableOrderedSet+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSMutableOrderedSet (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSOrderedSetM_ = objc_getClass("__NSOrderedSetM");
        
        mondo_swizzleInstanceMethodWithTarget(NSOrderedSetM_,
                                              @selector(objectAtIndex:),
                                              @selector(mondo_objectAtIndex:));
        mondo_swizzleInstanceMethodWithTarget(NSOrderedSetM_,
                                              @selector(insertObject:atIndex:),
                                              @selector(mondo_insertObject:atIndex:));
        mondo_swizzleInstanceMethodWithTarget(NSOrderedSetM_,
                                              @selector(removeObjectAtIndex:),
                                              @selector(mondo_removeObjectAtIndex:));
        mondo_swizzleInstanceMethodWithTarget(NSOrderedSetM_,
                                              @selector(replaceObjectAtIndex:withObject:),
                                              @selector(mondo_replaceObjectAtIndex:withObject:));
        mondo_swizzleInstanceMethodWithTarget(NSOrderedSetM_,
                                              @selector(addObject:),
                                              @selector(mondo_addObject:));
        
        
    });
}

- (id)mondo_objectAtIndex:(NSUInteger)idx{
    if (idx < self.count) {
        return [self mondo_objectAtIndex:idx];
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:@(idx).stringValue forKey:@"idx"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (void)mondo_insertObject:(id)object atIndex:(NSUInteger)idx{
    if (idx <= self.count && object) {
        [self mondo_insertObject:object atIndex:idx];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界或参数为空"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(idx).stringValue forKey:@"idx"];
        [userInfo setObject:object ? NSStringFromClass([object class]) : @"nil" forKey:@"object"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_removeObjectAtIndex:(NSUInteger)idx{
    if (idx < self.count) {
        [self mondo_removeObjectAtIndex:idx];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(idx).stringValue forKey:@"idx"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_replaceObjectAtIndex:(NSUInteger)idx withObject:(id)object{
    if (idx < self.count && object) {
        [self mondo_replaceObjectAtIndex:idx withObject:object];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界或参数为空"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(idx).stringValue forKey:@"idx"];
        [userInfo setObject:object ? NSStringFromClass([object class]) : @"nil" forKey:@"object"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_addObject:(id)object{
    if (object) {
        [self mondo_addObject:object];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为空"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

@end
