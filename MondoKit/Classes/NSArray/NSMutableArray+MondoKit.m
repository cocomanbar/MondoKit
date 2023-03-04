//
//  NSMutableArray+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSMutableArray+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSMutableArray (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSArrayM_ = objc_getClass("__NSArrayM");
        
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(addObject:),
                                              @selector(mondo_addObject:));
        
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(insertObject:atIndex:),
                                              @selector(mondo_insertObject:atIndex:));
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(insertObjects:atIndexes:),
                                              @selector(mondo_insertObjects:atIndexes:));
        
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(removeObjectAtIndex:),
                                              @selector(mondo_removeObjectAtIndex:));
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(removeObjectsAtIndexes:),
                                              @selector(mondo_removeObjectsAtIndexes:));
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(removeObjectsInRange:),
                                              @selector(mondo_removeObjectsInRange:));
        
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(replaceObjectAtIndex:withObject:),
                                              @selector(mondo_replaceObjectAtIndex:withObject:));
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(replaceObjectsAtIndexes:withObjects:),
                                              @selector(mondo_replaceObjectsAtIndexes:withObjects:));
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(replaceObjectsInRange:withObjectsFromArray:),
                                              @selector(mondo_replaceObjectsInRange:withObjectsFromArray:));
        
        mondo_swizzleInstanceMethodWithTarget(NSArrayM_,
                                              @selector(setObject:atIndexedSubscript:),
                                              @selector(mondo_setObject:atIndexedSubscript:));
        
    });
}

- (void)mondo_addObject:(id)anObject {
    if (anObject) {
        [self mondo_addObject:anObject];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数nil"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject && index <= self.count) {
        [self mondo_insertObject:anObject atIndex:index];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数nil或越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(index).stringValue forKey:@"index"];
        [userInfo setObject:anObject ? NSStringFromClass([anObject class]) : @"nil" forKey:@"anObject"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_removeObjectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        [self mondo_removeObjectAtIndex:index];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(index).stringValue forKey:@"index"];
        [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    NSMutableIndexSet *mutiSet = [indexes mutableCopy];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx < self.count) {
            [mutiSet addIndex:idx];
        }
    }];
    if (mutiSet.count != indexes.count) {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(indexes.count).stringValue forKey:@"indexes.c"];
        [userInfo setObject:@(mutiSet.count).stringValue forKey:@"mutiSet.c"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
    [self mondo_removeObjectsAtIndexes:[mutiSet copy]];
}

- (void)mondo_removeObjectsInRange:(NSRange)range{
    if (range.location + range.length <= self.count) {
        [self mondo_removeObjectsInRange:range];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (index < self.count && anObject) {
        [self mondo_replaceObjectAtIndex:index withObject:anObject];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界或nil"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:anObject ? NSStringFromClass([anObject class]) : @"nil" forKey:@"anObject"];
        [userInfo setObject:@(index).stringValue forKey:@"index"];
        [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray{
    if (range.location + range.length <= self.count) {
        [self mondo_replaceObjectsInRange:range withObjectsFromArray:otherArray];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    @try {
        [self mondo_insertObjects:objects atIndexes:indexes];
    }
    @catch (NSException *exception) {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(indexes.count).stringValue forKey:@"indexes.count"];
        [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
        [userInfo setObject:@"indexes内有值越界" forKey:@"other"];
        NSException *exception2 = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception2];
    }
    @finally {
        
    }
}

- (void)mondo_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects {
    @try {
        [self mondo_replaceObjectsAtIndexes:indexes withObjects:objects];
    }
    @catch (NSException *exception) {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(indexes.count).stringValue forKey:@"indexes.count"];
        [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
        [userInfo setObject:@"indexes内有值越界" forKey:@"other"];
        NSException *exception2 = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception2];
    }
    @finally {
        
    }
}

- (void)mondo_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (obj && idx <= self.count) {
        [self mondo_setObject:obj atIndexedSubscript:idx];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界或nil"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:obj ? NSStringFromClass([obj class]) : @"nil" forKey:@"obj"];
        [userInfo setObject:@(idx).stringValue forKey:@"idx"];
        [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

@end
