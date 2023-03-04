//
//  NSOrderedSet+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSOrderedSet+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSOrderedSet (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSOrderedSetI_ = objc_getClass("__NSOrderedSetI");
        
        mondo_swizzleInstanceMethodWithTarget(NSOrderedSetI_,
                                              @selector(objectAtIndex:),
                                              @selector(mondo_objectAtIndex:));
        
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

@end
