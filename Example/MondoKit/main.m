//
//  main.m
//  MondoKit
//
//  Created by cocomanbar on 02/27/2023.
//  Copyright (c) 2023 cocomanbar. All rights reserved.
//

@import UIKit;
#import "MondoAppDelegate.h"
#import <MondoKit/MondoService.h>

int main(int argc, char * argv[])
{
    
    [MondoService reportExceptionTrace:^(NSException * _Nullable exc) {
        NSLog(@"get exc: %@   rea: %@   name: %@   info: %@", exc, exc.reason, exc.name, exc.userInfo);
    }];
    [MondoService setEnable:YES];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([MondoAppDelegate class]));
    }
}
