//
//  NSData+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSData+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSData (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self mondo_swizzling:objc_getClass("NSConcreteData")];
        [self mondo_swizzling:objc_getClass("_NSZeroData")];
        [self mondo_swizzling:objc_getClass("_NSInlineData")];
        [self mondo_swizzling:objc_getClass("__NSCFData")];
        
    });
}

+ (void)mondo_swizzling:(Class)cls{
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(subdataWithRange:),
                                          @selector(mondo_subdataWithRange:));
    mondo_swizzleInstanceMethodWithTarget(cls,
                                          @selector(rangeOfData:options:range:),
                                          @selector(mondo_rangeOfData:options:range:));
}

- (NSData *)mondo_subdataWithRange:(NSRange)range{
    if (range.location + range.length <= self.length) {
        return [self mondo_subdataWithRange:range];;
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    
    return nil;
}

- (NSRange)mondo_rangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange{
    if (searchRange.location + searchRange.length <= self.length) {
        return [self mondo_rangeOfData:dataToFind options:mask range:searchRange];;
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:NSStringFromRange(searchRange) forKey:@"range"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return NSMakeRange(0, 0);
}

@end
