//
//  MondoKVOProxy.m
//  MondoKit
//
//  Created by tanxl on 2023/3/1.
//

#import "MondoKVOProxy.h"
#import "MondoCFuntion.h"

@interface MondoKVOInfo : NSObject

@end

@implementation MondoKVOInfo
{
    @package
    __weak NSObject *_observer;
    NSString *_observerMD5;
    NSString *_keyPath;
    NSKeyValueObservingOptions _options;
    void *_context;
}

@end

@interface MondoKVOProxy ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableArray <MondoKVOInfo * > *> *mondo_keyPathMaps;
@property (nonatomic, strong) NSLock *mondo_kvo_lock;

@end

@implementation MondoKVOProxy

- (NSLock *)mondo_kvo_lock {
    if (!_mondo_kvo_lock){
        _mondo_kvo_lock = [[NSLock alloc] init];
        _mondo_kvo_lock.name = @"mondo_kvo_lock";
    }
    return _mondo_kvo_lock;
}

- (NSMutableDictionary<NSString *,NSMutableArray<MondoKVOInfo *> *> *)mondo_keyPathMaps {
    if (!_mondo_keyPathMaps) {
        _mondo_keyPathMaps = [NSMutableDictionary dictionary];
    }
    return _mondo_keyPathMaps;
}

/// 尝试添加观察者，成功表示可以添加观察者并添加到缓存，失败代表已经缓存存在观察者
- (BOOL)mondo_didObserver:(NSObject *)observer
               forKeyPath:(NSString *)keyPath
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context
{
    [self.mondo_kvo_lock lock];
    /// 1.解决重复添加问题
    __block BOOL isExist = NO;
    NSMutableArray <MondoKVOInfo *> *kvoInfos = [self mondo_getKVOInfosForKeypath:keyPath];
    [kvoInfos enumerateObjectsUsingBlock:^(MondoKVOInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj->_observer == observer) {
            isExist = YES;
        }
    }];
    if (isExist) {
        [self.mondo_kvo_lock unlock];
        return !isExist;
    }
    MondoKVOInfo *info = [[MondoKVOInfo alloc] init];
    info->_observer = observer;
    info->_observerMD5 = mondo_md5_objc(observer);
    info->_keyPath = keyPath;
    info->_options = options;
    info->_context = context;
    [kvoInfos addObject:info];
    [self mondo_setKVOInfos:kvoInfos ForKeypath:keyPath];
    [self.mondo_kvo_lock unlock];
    return true;
}

/// 尝试根据keyPath移除观察者
- (BOOL)mondo_didRemoveObserver:(NSObject *)observer
                     forKeyPath:(NSString *)keyPath
{
    [self.mondo_kvo_lock lock];
    NSMutableArray <MondoKVOInfo *> *kvoInfos = [self mondo_getKVOInfosForKeypath:keyPath];
    __block MondoKVOInfo *kvoInfo = nil;
    [kvoInfos enumerateObjectsUsingBlock:^(MondoKVOInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj->_observerMD5 isEqualToString:mondo_md5_objc(observer)]) {
            kvoInfo = obj;
            *stop = YES;
        }
    }];
    if (kvoInfo) {
        [kvoInfos removeObject:kvoInfo];
        /// 说明该keypath没有observer观察组，可以移除该键
        if (kvoInfos.count == 0) {
            [self.mondo_keyPathMaps removeObjectForKey:keyPath];
        }
    }
    [self.mondo_kvo_lock unlock];
    return kvoInfo ? true : false;
}

/// 获取所有keyPaths记录
- (NSArray *)mondo_getAllKeypaths{
    NSArray <NSString *>* keyPaths = [self.mondo_keyPathMaps.allKeys copy];
    return keyPaths;
}

/// 移除keyPath对应的记录
- (void)mondo_removeObjectForKeyPath:(NSString *)keyPath {
    if (keyPath) {
        [self.mondo_keyPathMaps removeObjectForKey:keyPath];
    }
}

/// 获取keyPath对应的记录
- (nullable id)mondo_getObserverForKeyPath:(NSString *)keyPath {
    
    id objc;
    if (keyPath) {
        NSMutableArray <MondoKVOInfo *> *kvoInfos = [self mondo_getKVOInfosForKeypath:keyPath];
        MondoKVOInfo *info = kvoInfos.firstObject;
        return info->_observer;
    }
    return objc;
}

/// 代理中心转发对应的观察行为
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSMutableArray <MondoKVOInfo *> *kvoInfos = [self mondo_getKVOInfosForKeypath:keyPath];
    [kvoInfos enumerateObjectsUsingBlock:^(MondoKVOInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj->_keyPath isEqualToString:keyPath]) {
            NSObject *observer = obj->_observer;
            if (observer) {
                [observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            }
        }
    }];
}

/// 根据keyPat缓存新的观察对象数组
- (void)mondo_setKVOInfos:(NSMutableArray *)kvoInfos ForKeypath:(NSString *)keypath{
    if (![self.mondo_keyPathMaps.allKeys containsObject:keypath]) {
        if (keypath) {
            self.mondo_keyPathMaps[keypath] = kvoInfos;
        }
    }
}

/// 通过keyPath获取缓存观察对象数组
- (NSMutableArray *)mondo_getKVOInfosForKeypath:(NSString *)keypath{
    if ([self.mondo_keyPathMaps.allKeys containsObject:keypath]) {
        return [self.mondo_keyPathMaps objectForKey:keypath];
    }else{
        return [NSMutableArray array];
    }
}

@end
