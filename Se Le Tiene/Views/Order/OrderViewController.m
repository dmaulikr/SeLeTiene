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
@synthesize btnAZOfr,btnAZPro,btnCal,btnUbi,btnOrder;

- (void)viewDidLoad {
    [super viewDidLoad];
    btnCal.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnCal.layer.borderWidth = 1.0f;
    btnCal.tag = 1;
    btnUbi.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnUbi.layer.borderWidth = 1.0f;
    btnUbi.tag = 2;
    btnAZOfr.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnAZOfr.layer.borderWidth = 1.0f;
    btnAZOfr.tag = 3;
    btnAZPro.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnAZPro.layer.borderWidth = 1.0f;
    btnAZPro.tag = 4;
    btnOrder.layer.cornerRadius = 5.0f;
    
    if(order){
        UIButton *sr = (UIButton*)[self.view viewWithTag:order];
        sr.backgroundColor = [UIColor colorWithRed:0.243 green:0.592 blue:0.812 alpha:1];
        [sr setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (IBAction)activeOrder:(id)sender {
    UIButton *tmpBtn = sender;
    if (tmpBtn.tag != order) {
        btnCal.backgroundColor = [UIColor whiteColor];
        [btnCal setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btnUbi.backgroundColor = [UIColor whiteColor];
        [btnUbi setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btnAZOfr.backgroundColor = [UIColor whiteColor];
        [btnAZOfr setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btnAZPro.backgroundColor = [UIColor whiteColor];
        [btnAZPro setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        tmpBtn.backgroundColor = [UIColor colorWithRed:0.243 green:0.592 blue:0.812 alpha:1];
        [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        order = tmpBtn.tag;
    }
}

- (IBAction)doOrder:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
