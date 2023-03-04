//
//  MondoCFuntion.m
//  MondoKit
//
//  Created by tanxl on 2023/2/27.
//

#import "MondoCFuntion.h"
#import <objc/runtime.h>
#include <CommonCrypto/CommonCrypto.h>

BOOL mondo_swizzleClassMethodWithTarget(Class orignalClass, SEL oriSel, SEL swizzleSel) {
    
    if (!orignalClass) {
        return false;
    }
    
    //方法
    Method originalMethod = class_getClassMethod([orignalClass class], oriSel);
    Method swizzleMethod = class_getClassMethod([orignalClass class], swizzleSel);
    
    if (!originalMethod) {
        // 类方法存储在父类里
        // 在oriMethod为nil时，替换后将swizzledSEL复制一个不做任何事的空实现，代码如下:
        class_addMethod(object_getClass(orignalClass), oriSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        method_setImplementation(swizzleMethod, imp_implementationWithBlock(^(id self, SEL _cmd){
            NSAssert(false, @"Here comes an empty method implementation.");
        }));
    }
    
    // 交换方法:
    // 交换自己有的方法
    //      因为自己有意味添加方法失败
    // 交换自己没有实现的方法:
    //      首先第一步:会先尝试给自己添加要交换的方法
    //      然后再将父类的IMP给swizzle
    BOOL didAddMethod = class_addMethod(object_getClass(orignalClass), oriSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        class_replaceMethod(object_getClass(orignalClass), swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, (swizzleMethod));
    }
    
    return true;
}

BOOL mondo_swizzleInstanceMethodWithTarget(Class orignalClass, SEL oriSel, SEL swizzleSel) {
    
    if (!orignalClass) {
        return false;
    }
    
    //方法
    Method origMethod = class_getInstanceMethod(orignalClass, oriSel);
    Method swizzleMethod = class_getInstanceMethod(orignalClass, swizzleSel);
    
    if (!origMethod) {
        // 实例方法存在类里
        // 在oriMethod为nil时，替换后将swizzledSEL复制一个不做任何事的空实现，代码如下:
        class_addMethod(orignalClass, oriSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        method_setImplementation(swizzleMethod, imp_implementationWithBlock(^(id self, SEL _cmd) {
            NSAssert(false, @"Here comes an empty method implementation.");
        }));
    }
    
    // 交换方法:
    // 交换自己有的方法
    //      因为自己有意味添加方法失败
    // 交换自己没有实现的方法
    //   首先第一步:会先尝试给自己添加要交换的方法
    //   然后再将父类的IMP给swizzle
    BOOL didAddMethod = class_addMethod(orignalClass, oriSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        class_replaceMethod(orignalClass, swizzleSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
    
    return true;
}

NSString *mondo_md5_objc(id object) {
    
    NSString *oriStr;
    
    if ([object isKindOfClass:NSString.class]) {
        oriStr = object;
    } else if ([object isKindOfClass:NSObject.class]) {
        oriStr = [NSString stringWithFormat:@"%p", object];
    }
    
    if (!oriStr) {
        return oriStr;
    }
    
    const char *str = oriStr.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    NSMutableString *md5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5 appendFormat:@"%02x", buffer[i]];
    }
    return [md5 copy];
}

