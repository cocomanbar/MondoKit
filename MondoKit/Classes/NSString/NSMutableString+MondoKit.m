//
//  NSMutableString+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSMutableString+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSMutableString (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("__NSCFString");
        mondo_swizzleInstanceMethodWithTarget(cls,
                                              @selector(appendString:),
                                              @selector(mondo_appendString:));
        mondo_swizzleInstanceMethodWithTarget(cls,
                                              @selector(insertString:atIndex:),
                                              @selector(mondo_insertString:atIndex:));
        mondo_swizzleInstanceMethodWithTarget(cls,
                                              @selector(deleteCharactersInRange:),
                                              @selector(mondo_deleteCharactersInRange:));
        
    });
}

- (void)mondo_appendString:(NSString *)aString{
    if (aString) {
        [self mondo_appendString:aString];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为nil"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_insertString:(NSString *)aString atIndex:(NSUInteger)loc{
    if (aString && loc <= self.length) {
        [self mondo_insertString:aString atIndex:loc];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为nil或越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:[self copy] forKey:@"self"];
        [userInfo setObject:@(loc).stringValue forKey:@"loc"];
        [userInfo setObject:[aString copy] forKey:@"aString"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_deleteCharactersInRange:(NSRange)range{
    if (range.location + range.length <= self.length){
        [self mondo_deleteCharactersInRange:range];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:[self copy] forKey:@"self"];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

@end
