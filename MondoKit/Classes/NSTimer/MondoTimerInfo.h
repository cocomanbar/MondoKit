//
//  MondoTimerInfo.h
//  MondoKit
//
//  Created by tanxl on 2023/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kmondo_timer_intercept_sel;

@interface MondoTimerInfo : NSObject

+ (instancetype)mondo_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                               target:(id)target
                                             selector:(SEL)selector
                                             userInfo:(id)userInfo
                                              repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
