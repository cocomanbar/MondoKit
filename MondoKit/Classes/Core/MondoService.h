//
//  MondoService.h
//  MondoKit
//
//  Created by tanxl on 2023/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MondoService : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)shared;

+ (BOOL)isEnabled;

+ (void)dealException:(nullable NSException *)aException;
+ (void)reportExceptionTrace:(nullable void(^)(NSException * _Nullable))report;

+ (void)setEnable:(BOOL)enable;
+ (void)close;

@end

NS_ASSUME_NONNULL_END
