//
//  OrderViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/9/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize btnAZOfr,btnAZPro,btnCal,btnUbi;

- (void)viewDidLoad {
    [super viewDidLoad];
    btnCal.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnCal.layer.borderWidth = 1.0f;
    btnUbi.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnUbi.layer.borderWidth = 1.0f;
    btnAZOfr.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnAZOfr.layer.borderWidth = 1.0f;
    btnAZPro.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnAZPro.layer.borderWidth = 1.0f;
}

- (IBAction)activeOrder:(id)sender {
    UIButton *tmpBtn = sender;
    tmpBtn.backgroundColor = [UIColor colorWithRed:0.243 green:0.592 blue:0.812 alpha:1];
    [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
@end
