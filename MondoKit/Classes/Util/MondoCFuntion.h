//
//  MondoCFuntion.h
//  MondoKit
//
//  Created by tanxl on 2023/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  hook class method
 */
FOUNDATION_EXPORT BOOL mondo_swizzleClassMethodWithTarget(Class oriClass, SEL oriSel, SEL swizzleSel);

/**
 *  hook instance method
 */
FOUNDATION_EXPORT BOOL mondo_swizzleInstanceMethodWithTarget(Class oriClass, SEL oriSel, SEL swizzleSel);


/**
 *  md5 for objc
 */
FOUNDATION_EXPORT NSString *mondo_md5_objc(id object);


NS_ASSUME_NONNULL_END
