//
//  MondoWeakProxy.h
//  MondoKit
//
//  Created by tanxl on 2023/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MondoWeakProxy : NSObject

@property (nonatomic, weak, readonly, nullable) id target;

- (instancetype)initWithTarget:(id _Nullable)target;
+ (instancetype)proxyWithTarget:(id _Nullable)target;

@end

NS_ASSUME_NONNULL_END
