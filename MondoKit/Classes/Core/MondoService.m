//
//  MondoService.m
//  MondoKit
//
//  Created by tanxl on 2023/2/27.
//

#import "MondoService.h"

NSString *const kMONDOKIT_ENABLE_KEY = @"kMONDOKIT_ENABLE_KEY";

@interface MondoService ()

@property (nonatomic, copy, nullable) void(^reportException)(NSException * _Nullable);

@property (nonatomic, assign) BOOL stopReport;

@end

@implementation MondoService

+ (instancetype)shared{
    static MondoService *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MondoService alloc] init];
    });
    return _instance;
}

+ (void)dealException:(nullable NSException *)aException {
    
    if ([MondoService shared].stopReport) {
        return;
    }
    if ([MondoService shared].reportException && [aException isKindOfClass:NSException.class]) {
        [MondoService shared].reportException(aException);
    }
}

+ (void)reportExceptionTrace:(nullable void(^)(NSException * _Nullable))report {
    
    [[MondoService shared] setReportException:report];
}

+ (void)setEnable:(BOOL)enable {
    
    [[NSUserDefaults standardUserDefaults] setBool:enable forKey:kMONDOKIT_ENABLE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)close {
    
    [[MondoService shared] setStopReport:true];
}

+ (BOOL)isEnabled {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:kMONDOKIT_ENABLE_KEY];
}

@end
