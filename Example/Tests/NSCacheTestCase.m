//
//  NSCacheTestCase.m
//  MondoKit_Tests
//
//  Created by tanxl on 2023/3/2.
//  Copyright © 2023 cocomanbar. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSCacheTestCase : XCTestCase<NSCacheDelegate>
{
    NSCache *_cache;
}

@end

@implementation NSCacheTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _cache = [[NSCache alloc] init];
    _cache.countLimit = 1;
    _cache.delegate = self;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    _cache = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [_cache setObject:nil forKey:nil];
    [_cache setObject:nil forKey:@"key"];
    [_cache setObject:@"key" forKey:nil];
    
    [_cache setObject:nil forKey:nil cost:0];
    [_cache setObject:nil forKey:@"key" cost:0];
    [_cache setObject:@"key" forKey:nil cost:0];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    
    XCTAssert(false, @"没有成功屏蔽nil.");
}

@end
