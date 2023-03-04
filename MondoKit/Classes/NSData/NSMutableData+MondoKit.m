//
//  NSMutableData+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSMutableData+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSMutableData (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSConcreteMutableData_ = objc_getClass("NSConcreteMutableData");
        
        mondo_swizzleInstanceMethodWithTarget(NSConcreteMutableData_,
                                              @selector(subdataWithRange:),
                                              @selector(mondo_subdataWithRange:));
        mondo_swizzleInstanceMethodWithTarget(NSConcreteMutableData_,
                                              @selector(rangeOfData:options:range:),
                                              @selector(mondo_rangeOfData:options:range:));
        mondo_swizzleInstanceMethodWithTarget(NSConcreteMutableData_,
                                              @selector(resetBytesInRange:),
                                              @selector(mondo_resetBytesInRange:));
        mondo_swizzleInstanceMethodWithTarget(NSConcreteMutableData_,
                                              @selector(replaceBytesInRange:withBytes:),
                                              @selector(mondo_replaceBytesInRange:withBytes:));
        mondo_swizzleInstanceMethodWithTarget(NSConcreteMutableData_,
                                              @selector(replaceBytesInRange:withBytes:length:),
                                              @selector(mondo_replaceBytesInRange:withBytes:length:));
        
    });
}

- (NSData *)mondo_subdataWithRange:(NSRange)range{
    if (range.location + range.length <= self.length) {
        return [self mondo_subdataWithRange:range];
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

- (void)mondo_resetBytesInRange:(NSRange)range{
    if (range.location + range.length <= self.length) {
        [self mondo_resetBytesInRange:range];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes{
    if (range.location + range.length <= self.length) {
        [self mondo_replaceBytesInRange:range withBytes:bytes];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_replaceBytesInRange:(NSRange)range withBytes:(const void *)replacementBytes length:(NSUInteger)replacementLength{
    if (range.location + range.length <= self.length) {
        [self mondo_replaceBytesInRange:range withBytes:replacementBytes length:replacementLength];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

@end
