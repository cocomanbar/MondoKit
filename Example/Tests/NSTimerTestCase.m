//
//  NSTimerTestCase.m
//  MondoKit_Tests
//
//  Created by tanxl on 2023/3/2.
//  Copyright © 2023 cocomanbar. All rights reserved.
//

#import <XCTest/XCTest.h>

@class NSTimerXCTestLog;

@interface NSTimerTestCase : XCTestCase

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *mark;

@property (nonatomic, strong) NSTimerXCTestLog *log;

@end

@interface NSTimerXCTestLog : NSObject

@property (nonatomic, weak) NSTimerTestCase *testCase;

@end

@implementation NSTimerXCTestLog

- (void)timerAction:(NSTimer *)timer {
    
    NSLog(@"执行了timer方法：_timer = %@，timer = %@，_mark = %@", self.testCase.timer, timer, self.testCase.mark);
    
    self.testCase.mark = @"1";
}


@end

@implementation NSTimerTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // 测试事项
//    因为scheduledTimerWithTimeInterval不仅仅是创建了NSTimer对象, 还把该对象加入到了当前的runloop
//    加入到runloop后, 除了self之外iOS系统也会强引用NSTimer对象
    
    _mark = @"1";
    
    
    _log = [[NSTimerXCTestLog alloc] init];
    _log.testCase = self;
    
    // 测试1
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:_log selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    // 测试2
    _timer = [NSTimer timerWithTimeInterval:1 target:_log selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:(NSRunLoopCommonModes)];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    __weak typeof(self)weakSelf = self;
    XCTestExpectation* expect = [self expectationWithDescription:@"Oh, key1!"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(3); // 先看看定时器是不是起效，延迟一会再执行销毁
        
        weakSelf.log = nil;     // target销毁，默认控制器销毁忘记处理timer的情况
        
        sleep(2);
        
        weakSelf.mark = @"2";    // 通过绑定变量变化判断，定时销毁后，方法还在走  _valid -> 1
        
        sleep(3); // 再延迟一会，检测是否定时器还在走? 在走说明防护失败，没有则成功
        
        [expect fulfill];   //告知异步测试结束
    });
    
    //等待10秒，若该测试未结束（未收到 fulfill方法）则测试结果为失败
    [self waitForExpectationsWithTimeout:50 handler:^(NSError *error) {
        //Do something when time out
        
        XCTAssert([weakSelf.mark isEqualToString:@"2"], "定时销毁失败."); //通过测试
        
    }];
    
}

@end
