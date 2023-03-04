//
//  MondoKVOProxy.h
//  MondoKit
//
//  Created by tanxl on 2023/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MondoKVOProxy : NSObject

/// 尝试添加观察者，成功表示可以添加观察者并添加到缓存，失败代表已经缓存存在观察者
- (BOOL)mondo_didObserver:(NSObject *)observer
               forKeyPath:(NSString *)keyPath
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context;

/// 尝试根据keyPath移除观察者
- (BOOL)mondo_didRemoveObserver:(NSObject *)observer
                     forKeyPath:(NSString *)keyPath;

/// 获取所有keyPaths记录
- (NSArray *)mondo_getAllKeypaths;

/// 移除keyPath对应的记录
- (void)mondo_removeObjectForKeyPath:(NSString *)keyPath;

/// 获取keyPath对应的记录
- (nullable id)mondo_getObserverForKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
