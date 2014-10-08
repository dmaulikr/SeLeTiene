//
//  LoginViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 9/30/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    self.btnOffer.titleLabel.numberOfLines = 2;
    self.btnOffer.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnOffer.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (IBAction)getInformation:(id)sender {
    NSLog(@"Funciona Boton");
    
}

@end
