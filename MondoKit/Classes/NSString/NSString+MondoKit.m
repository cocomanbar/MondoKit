//
//  NSString+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSString+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSString (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("NSPlaceholderString");
        mondo_swizzleInstanceMethodWithTarget(cls,
                                              @selector(initWithString:),
                                              @selector(mondo_initWithString:));
        
        [self mondo_swizzling:objc_getClass("__NSCFConstantString")];
        [self mondo_swizzling:objc_getClass("NSTaggedPointerString")];
    });
}

+ (void)mondo_swizzling:(Class)cls {
    
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(hasPrefix:),
                                          @selector(mondo_hasPrefix:));
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(hasSuffix:),
                                          @selector(mondo_hasSuffix:));
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(substringFromIndex:),
                                          @selector(mondo_substringFromIndex:));
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(substringToIndex:),
                                          @selector(mondo_substringToIndex:));
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(substringWithRange:),
                                          @selector(mondo_substringWithRange:));
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(characterAtIndex:),
                                          @selector(mondo_characterAtIndex:));
    
    // 注意以下两个顺序
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(stringByReplacingOccurrencesOfString:withString:options:range:),
                                          @selector(mondo_stringByReplacingOccurrencesOfString:withString:options:range:));
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(stringByReplacingCharactersInRange:withString:),
                                          @selector(mondo_stringByReplacingCharactersInRange:withString:));
}

#pragma mark - Swizzle

- (instancetype)mondo_initWithString:(NSString *)aString{
    if (aString) {
        return [self mondo_initWithString:aString];
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为nil"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (BOOL)mondo_hasPrefix:(NSString *)aString{
    if (aString) {
        return [self mondo_hasPrefix:aString];
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为nil"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return NO;
}

- (BOOL)mondo_hasSuffix:(NSString *)aString{
    if (aString) {
        return [self mondo_hasSuffix:aString];
    }
        
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为nil"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return NO;
}

- (NSString *)mondo_substringFromIndex:(NSUInteger)from{
    if (from <= self.length) {
        return [self mondo_substringFromIndex:from];;
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"截取越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[self copy] forKey:@"self"];
    [userInfo setObject:@(from).stringValue forKey:@"from"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (NSString *)mondo_substringToIndex:(NSUInteger)index{
    if (index <= self.length) {
        return [self mondo_substringToIndex:index];;
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"截取越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[self copy] forKey:@"self"];
    [userInfo setObject:@(index).stringValue forKey:@"from"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (NSString *)mondo_substringWithRange:(NSRange)range{
    if (range.location + range.length <= self.length) {
        return [self mondo_substringWithRange:range];;
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"截取越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[self copy] forKey:@"self"];
    [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (unichar)mondo_characterAtIndex:(NSUInteger)index{
    if (index < self.length) {
        return [self mondo_characterAtIndex:index];;
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"截取越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[self copy] forKey:@"self"];
    [userInfo setObject:@(index).stringValue forKey:@"index"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return 0;
}

- (NSString *)mondo_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange{
    if (searchRange.location + searchRange.length <= self.length) {
        return [self mondo_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"截取越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[self copy] forKey:@"self"];
    [userInfo setObject:NSStringFromRange(searchRange) forKey:@"index"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (NSString *)mondo_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement{
    if (range.location + range.length <= self.length) {
        return [self mondo_stringByReplacingCharactersInRange:range withString:replacement];
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"截取越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[self copy] forKey:@"self"];
    [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

@end
