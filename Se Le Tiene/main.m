//
//  main.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 9/28/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


int dev;
int order;
NSMutableArray *productsArray;
int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *deviceModel = (NSString*)[UIDevice currentDevice].model;
        if ([[deviceModel substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"iPad"]) {
            dev = 1;
        } else {
            dev = 2;
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
