//
//  NSMutableAttributedString+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSMutableAttributedString+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSMutableAttributedString (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("NSConcreteMutableAttributedString");
        
        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(replaceCharactersInRange:withString:),
                                     @selector(mondo_replaceCharactersInRange:withString:));
        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(replaceCharactersInRange:withAttributedString:),
                                     @selector(mondo_replaceCharactersInRange:withAttributedString:));

        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(setAttributes:range:),
                                     @selector(mondo_setAttributes:range:));
        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(addAttributes:range:),
                                     @selector(mondo_addAttributes:range:));
        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(addAttribute:value:range:),
                                     @selector(mondo_addAttribute:value:range:));

        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(removeAttribute:range:),
                                     @selector(mondo_removeAttribute:range:));

        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(insertAttributedString:atIndex:),
                                     @selector(mondo_insertAttributedString:atIndex:));
        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(appendAttributedString:),
                                     @selector(mondo_appendAttributedString:));
        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(deleteCharactersInRange:),
                                     @selector(mondo_deleteCharactersInRange:));
        mondo_swizzleInstanceMethodWithTarget(cls,
                                     @selector(setAttributedString:),
                                     @selector(mondo_setAttributedString:));
        
    });
}


- (void)mondo_replaceCharactersInRange:(NSRange)range withString:(NSString *)str{
    if (range.location + range.length <= self.length && str) {
        [self mondo_replaceCharactersInRange:range withString:str];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        [userInfo setObject:str?:@"nil" forKey:@"str"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString{
    if (range.location + range.length <= self.length && attrString) {
        [self mondo_replaceCharactersInRange:range withAttributedString:attrString];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        [userInfo setObject:attrString?:@"nil" forKey:@"attrString"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range{
    if (range.location + range.length <= self.length) {
        [self mondo_setAttributes:attrs range:range];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_addAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range{
    if (range.location + range.length <= self.length) {
        [self mondo_addAttributes:attrs range:range];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range{
    if (range.location + range.length <= self.length) {
        [self mondo_addAttribute:name value:value range:range];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        [userInfo setObject:name?:@"nil" forKey:@"name"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_removeAttribute:(NSAttributedStringKey)name range:(NSRange)range{
    if (range.location + range.length <= self.length) {
        [self mondo_removeAttribute:name range:range];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        [userInfo setObject:name?:@"nil" forKey:@"name"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc{
    if (loc <= self.length) {
        [self mondo_insertAttributedString:attrString atIndex:loc];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@(loc).stringValue forKey:@"loc"];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        [userInfo setObject:[attrString copy] forKey:@"attrString"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_appendAttributedString:(NSAttributedString *)attrString{
    if (attrString) {
        [self mondo_appendAttributedString:attrString];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数nil"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        [userInfo setObject:[attrString copy] forKey:@"attrString"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_deleteCharactersInRange:(NSRange)range{
    if (range.location + range.length <= self.length) {
        [self mondo_deleteCharactersInRange:range];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数越界"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        [userInfo setObject:NSStringFromRange(range) forKey:@"range"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_setAttributedString:(NSAttributedString *)attrString{
    if (attrString) {
        [self mondo_setAttributedString:attrString];
    } else {
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数nil"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:[[self copy] string] forKey:@"self"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

@end
