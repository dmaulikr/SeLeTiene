//
//  main.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 9/28/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Connection.h"


int dev;
int order;
BOOL ret;
Connection *conn;
NSString *token;
NSMutableArray *productsArray;
NSMutableArray *favArray;
NSString *orderStr;
NSString *filterStr;
NSDictionary *depto;
NSDictionary *city;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        token = @"";
        orderStr = @"";
        filterStr = @"";
        NSString *deviceModel = (NSString*)[UIDevice currentDevice].model;
        if ([[deviceModel substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"iPad"]) {
            dev = 1;
        } else {
            dev = 2;
        }
        conn = [[Connection alloc] init];
        [conn openDB];
        token = [conn checkSession];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
