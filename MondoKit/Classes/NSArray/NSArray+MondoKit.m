//
//  NSArray+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSArray+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSArray (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //不同形式下的类型：
        //__NSArray0             仅仅初始化后不含有元素的数组   ( NSArray *arr2 =  [[NSArray alloc]init]; )
        //__NSSingleObjectArrayI 只有一个元素的数组           ( NSArray *arr3 =  [[NSArray alloc]initWithObjects: @"1",nil]; )
        //__NSPlaceholderArray   占位数组                   ( NSArray *arr4 =  [NSArray alloc]; )
        //__NSArrayI             初始化后的不可变数组         ( NSArray *arr1 =  @[@"1",@"2"]; )
        
        Class __NSArray = objc_getClass("NSArray");
        mondo_swizzleClassMethodWithTarget(__NSArray,
                                              @selector(arrayWithObjects:count:),
                                              @selector(mondo_arrayWithObjects:count:));
        mondo_swizzleInstanceMethodWithTarget(__NSArray,
                                              @selector(objectsAtIndexes:),
                                              @selector(mondo_objectsAtIndexes:));
        
        
        Class __NSArrayI = objc_getClass("__NSArrayI");
        mondo_swizzleInstanceMethodWithTarget(__NSArrayI,
                                              @selector(objectAtIndex:),
                                              @selector(mondo_objectAtIndexI:));
        mondo_swizzleInstanceMethodWithTarget(__NSArrayI,
                                              @selector(objectAtIndexedSubscript:),
                                              @selector(mondo_objectAtIndexedSubscript:));
        
        Class __NSSingleObjectArrayI = objc_getClass("__NSSingleObjectArrayI");
        mondo_swizzleInstanceMethodWithTarget(__NSSingleObjectArrayI,
                                              @selector(objectAtIndex:),
                                              @selector(mondo_objectAtIndexSingleI:));
        
        
        Class __NSArray0 = objc_getClass("__NSArray0");
        mondo_swizzleInstanceMethodWithTarget(__NSArray0,
                                              @selector(objectAtIndex:),
                                              @selector(mondo_objectAtIndex0:));
        
        
    });
}

+ (instancetype)mondo_arrayWithObjects:(id  _Nonnull const[])objects count:(NSUInteger)cnt {
    NSInteger index = 0;
    id _Nonnull __unsafe_unretained array[cnt];
    for (int i = 0; i < cnt; i++) {
        if (objects[i] != nil) {
            array[index] = objects[i];
            index++;
        }
    }
    if (index != cnt) {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数不对等"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(cnt).stringValue forKey:@"cnt"];
        [userInfo setObject:@(index).stringValue forKey:@"index"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
    
    return [self mondo_arrayWithObjects:array count:index];
}

- (id)mondo_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self mondo_objectAtIndex:index];;
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:@(index).stringValue forKey:@"index"];
    [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (id)mondo_objectAtIndex0:(NSUInteger)index{
    if (index < self.count) {
        return [self mondo_objectAtIndex0:index];;
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:@(index).stringValue forKey:@"index"];
    [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (id)mondo_objectAtIndexI:(NSUInteger)index{
    if (index < self.count) {
        return [self mondo_objectAtIndexI:index];;
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:@(index).stringValue forKey:@"index"];
    [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (id)mondo_objectAtIndexSingleI:(NSUInteger)index{
    if (index < self.count) {
        return [self mondo_objectAtIndexSingleI:index];;
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:@(index).stringValue forKey:@"index"];
    [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (id)mondo_objectAtIndexedSubscript:(NSUInteger)idx{
    if (idx < self.count) {
        return [self mondo_objectAtIndexedSubscript:idx];;
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:@(idx).stringValue forKey:@"index"];
    [userInfo setObject:@(self.count).stringValue forKey:@"self.count"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (NSArray *)mondo_objectsAtIndexes:(NSIndexSet *)indexes {
    NSMutableIndexSet *mutiSet = [indexes mutableCopy];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx < self.count) {
            [mutiSet addIndex:idx];
        }
    }];
    if (mutiSet.count != indexes.count) {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数不对等"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(indexes.count).stringValue forKey:@"indexes.count"];
        [userInfo setObject:@(mutiSet.count).stringValue forKey:@"mutiSet.count"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
    return [self mondo_objectsAtIndexes:[mutiSet copy]];
}

@end
