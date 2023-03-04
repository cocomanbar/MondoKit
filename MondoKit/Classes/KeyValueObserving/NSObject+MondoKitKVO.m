//
//  NSObject+MondoKitKVO.m
//  MondoKit
//
//  Created by tanxl on 2023/3/1.
//

#import "NSObject+MondoKitKVO.h"
#import <objc/runtime.h>
#import "MondoCFuntion.h"
#import "MondoService.h"
#import "MondoKVOProxy.h"

static void *kmondo_kvo_proxy_info_key = &kmondo_kvo_proxy_info_key;
static void *kmondo_already_add_kvo_key = &kmondo_already_add_kvo_key;

NSString *const kMondoAlreadyAddKVOKey = @"kMondoAlreadyAddKVOKey";

@interface NSObject ()

@property (nonatomic, strong) MondoKVOProxy *mondo_kvo_proxy_info;

@end

/**
 *  解决的问题：
 *      1.keyPath 重复监听
 *      2.keyPath 重复移除
 *      3.移除 不存在的keyPath
 *      4.自动管理移除所有监听
 */
@implementation NSObject (MondoKitKVO)

+ (void)load{
    if (![MondoService isEnabled]) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSObject_ = objc_getClass("NSObject");
        
        mondo_swizzleInstanceMethodWithTarget(NSObject_,
                                              @selector(addObserver:forKeyPath:options:context:),
                                              @selector(mondo_addObserver:forKeyPath:options:context:));
        
        mondo_swizzleInstanceMethodWithTarget(NSObject_,
                                              @selector(removeObserver:forKeyPath:),
                                              @selector(mondo_removeObserver:forKeyPath:));
        
        mondo_swizzleInstanceMethodWithTarget(NSObject_,
                                              NSSelectorFromString(@"dealloc"),
                                              NSSelectorFromString(@"mondo_dealloc_kvo"));
        
        
    });
}

- (void)setMondo_kvo_proxy_info:(MondoKVOProxy *)mondo_kvo_proxy_info {
    objc_setAssociatedObject(self, kmondo_kvo_proxy_info_key, mondo_kvo_proxy_info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MondoKVOProxy *)mondo_kvo_proxy_info {
    MondoKVOProxy *proxy_info = objc_getAssociatedObject(self, kmondo_kvo_proxy_info_key);
    if (![proxy_info isKindOfClass:MondoKVOProxy.class]) {
        proxy_info = [[MondoKVOProxy alloc] init];
        [self setMondo_kvo_proxy_info:proxy_info];
    }
    return proxy_info;
}

- (void)mondo_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    
    /// 标记此类有kvo行为
    objc_setAssociatedObject(self, kmondo_already_add_kvo_key, kMondoAlreadyAddKVOKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    /// 尝试接管KVO行为
    BOOL didAdd = [self.mondo_kvo_proxy_info mondo_didObserver:observer forKeyPath:keyPath options:options context:context];
    if (didAdd) {
        [self mondo_addObserver:self.mondo_kvo_proxy_info forKeyPath:keyPath options:options context:context];
    }else{
        /// 接管失败说明缓存存在相同观察者，属于重复添加行为
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"重复添加观察"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:observer ? NSStringFromClass([observer class]) : @"nil" forKey:@"observer"];
        [userInfo setObject:keyPath ?: @"nil" forKey:@"keyPath"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    /// 尝试移除观察者
    BOOL didRemove = [self.mondo_kvo_proxy_info mondo_didRemoveObserver:observer forKeyPath:keyPath];
    if (didRemove) {
        [self mondo_removeObserver:self.mondo_kvo_proxy_info forKeyPath:keyPath];
    }else{
        /// 移除失败观察者，属于重复移除行为
        NSString *name = NSStringFromClass(self.class);
        NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"移除失败观察者，属于重复移除行为"];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:observer ? NSStringFromClass([observer class]) : @"nil" forKey:@"observer"];
        [userInfo setObject:keyPath ?: @"nil" forKey:@"keyPath"];
        NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
        [MondoService dealException:exception];
    }
}

- (void)mondo_dealloc_kvo{
    NSString *value = objc_getAssociatedObject(self, kmondo_already_add_kvo_key);
    if (value && [value isEqualToString:kMondoAlreadyAddKVOKey]) {
        NSArray *keypaths = [self.mondo_kvo_proxy_info mondo_getAllKeypaths];
        
        if (keypaths.count > 0) {
            
            /// 解决delloc 未移除的crash.
            [keypaths enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL * _Nonnull stop) {
                /// 执行原方法移除
                id observer = [self.mondo_kvo_proxy_info mondo_getObserverForKeyPath:keyPath];
                [self.mondo_kvo_proxy_info mondo_didRemoveObserver:observer forKeyPath:keyPath];
                
                /// 移除本地缓存
                [self.mondo_kvo_proxy_info mondo_removeObjectForKeyPath:keyPath];
                
                /// 上报
                NSString *name = NSStringFromClass(self.class);
                NSString *reason = [NSString stringWithFormat:@"【%@】%@", NSStringFromSelector(_cmd), @"尚未有keyPath顺利移除."];
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:observer ? NSStringFromClass([observer class]) : @"nil" forKey:@"observer"];
                [userInfo setObject:keyPath ?: @"nil" forKey:@"keyPath"];
                NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:userInfo];
                [MondoService dealException:exception];
            }];
        }
    }
    [self mondo_dealloc_kvo];
}

@end
