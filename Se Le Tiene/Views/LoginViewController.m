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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)getInformation:(id)sender {
    NSLog(@"Funciona Boton");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
