//
//  NVControllerGeneric.m
//  eldorado
//
//  Created by Jorge Raul Ovalle Zuleta on 5/12/14.
//  Copyright (c) 2014 jomobile.co. All rights reserved.
//

#import "NVControllerGeneric.h"

@interface NVControllerGeneric ()

@end

@implementation NVControllerGeneric

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.000 green:0.329 blue:0.651 alpha:1]];    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bgHeader"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:17.0], NSFontAttributeName, nil]];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
