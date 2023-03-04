//
//  NSAttributedString+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSAttributedString+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSAttributedString (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("NSConcreteAttributedString");
        
        
        mondo_swizzleInstanceMethodWithTarget(cls,
                                              @selector(initWithString:),
                                              @selector(mondo_initWithString:));
        
        mondo_swizzleInstanceMethodWithTarget(cls,
                                              @selector(initWithString:attributes:),
                                              @selector(mondo_initWithString:attributes:));
        
        mondo_swizzleInstanceMethodWithTarget(cls,
                                              @selector(initWithAttributedString:),
                                              @selector(mondo_initWithAttributedString:));
        
        mondo_swizzleInstanceMethodWithTarget(cls,
                                              @selector(attributedSubstringFromRange:),
                                              @selector(mondo_attributedSubstringFromRange:));
        
    });
}

- (instancetype)mondo_initWithString:(NSString *)str{
    if (str) {
        return [self mondo_initWithString:str];
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数nil"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (instancetype)mondo_initWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs{
    if (str) {
        return [self mondo_initWithString:str attributes:attrs];
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数nil"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (instancetype)mondo_initWithAttributedString:(NSAttributedString *)attrStr{
    if (attrStr) {
        return [self mondo_initWithAttributedString:attrStr];
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数nil"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

- (NSAttributedString *)mondo_attributedSubstringFromRange:(NSRange)range{
    if (range.location + range.length <= self.length) {
        return [self mondo_attributedSubstringFromRange:range];
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
    [userInfo setObject:[self copy] forKey:@"self"];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

@end
