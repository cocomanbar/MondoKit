//
//  MondoListViewController.h
//  MondoKit_Example
//
//  Created by tanxl on 2023/3/1.
//  Copyright © 2023 cocomanbar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MondoListViewController : UIViewController

- (void)setRowTitle:(NSString *)title forKey:(NSString *)aKey;

- (void)executeAction:(NSString *)aKey;

@end

NS_ASSUME_NONNULL_END
