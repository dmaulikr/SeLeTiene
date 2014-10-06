//
//  FilterViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize star1,star2,star3,star4,star5;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stars = [[NSMutableArray alloc] initWithCapacity:5];
    
}

@end
