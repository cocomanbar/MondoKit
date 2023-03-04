//
//  KVOTestCase.m
//  MondoKit_Tests
//
//  Created by tanxl on 2023/3/1.
//  Copyright © 2023 cocomanbar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MondoKit/MondoKVOProxy.h>

@interface KVOTestCase : XCTestCase

@property (nonatomic, strong) UIView *testView;

@end

@interface NSObject ()

- (MondoKVOProxy *)mondo_kvo_proxy_info;

@end

@interface MondoKVOProxy ()

- (NSArray *)mondo_getAllKeypaths;

@end



@implementation KVOTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testView = [[UIView alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testView = nil;
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // 添加观察
    [self.testView addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionNew) context:NULL];
    
    // 应该会有记录
    MondoKVOProxy *proxy = [self.testView mondo_kvo_proxy_info];
    XCTAssert(proxy != nil, @"创建proxyinfo失败.");
    
    // 应该会有keypath
    NSArray *keyPaths = [proxy mondo_getAllKeypaths];
    XCTAssert(keyPaths.count == 1, @"添加keypath失败.");
    
    // 置空，但不手动移除观察，此时内部delloc 会自动移除
    self.testView = nil;
    
    // 检查是不是移除成功
    keyPaths = [proxy mondo_getAllKeypaths];
    XCTAssert(keyPaths.count == 0, @"移除keypath失败.");
}

- (void)testPerformanceExample {
    
}

@end
