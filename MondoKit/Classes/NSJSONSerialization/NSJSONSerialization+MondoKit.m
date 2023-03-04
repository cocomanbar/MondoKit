//
//  NSJSONSerialization+MondoKit.m
//  MondoKit
//
//  Created by tanxl on 2023/2/28.
//

#import "NSJSONSerialization+MondoKit.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"

@implementation NSJSONSerialization (MondoKit)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("NSJSONSerialization");
        
        mondo_swizzleClassMethodWithTarget(cls,
                                           @selector(JSONObjectWithData:options:error:),
                                           @selector(mondo_JSONObjectWithData:options:error:));
        mondo_swizzleClassMethodWithTarget(cls,
                                           @selector(JSONObjectWithStream:options:error:),
                                           @selector(mondo_JSONObjectWithStream:options:error:));
        mondo_swizzleClassMethodWithTarget(cls,
                                           @selector(dataWithJSONObject:options:error:),
                                           @selector(mondo_dataWithJSONObject:options:error:));
        
    });
}


+ (id)mondo_JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing  _Nullable *)error{
    if (data) {
        return [self mondo_JSONObjectWithData:data options:opt error:error];
    }
    
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为空"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

+ (id)mondo_JSONObjectWithStream:(NSInputStream *)stream options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing  _Nullable *)error{
    if (stream) {
        return [self mondo_JSONObjectWithStream:stream options:opt error:error];
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为空"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}

+ (id)mondo_dataWithJSONObject:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing  _Nullable *)error{
    if (data) {
        return [self mondo_dataWithJSONObject:data options:opt error:error];
    }
    NSString *name = NSStringFromClass(self.class);
    NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"参数为空"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
    [MondoService dealException:exception];
    return nil;
}


@end
