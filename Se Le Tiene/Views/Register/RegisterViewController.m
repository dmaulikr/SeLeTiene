//
//  RegisterViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize txtConfPass,txtEmail,txtName,txtPass,txtPhone,btnSignUp;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    txtName.layer.borderColor = [UIColor colorWithRed:0.110 green:0.624 blue:0.843 alpha:1].CGColor;
    txtName.layer.cornerRadius = 5.0f;
    txtName.layer.borderWidth = 2.0f;
    txtName.leftView = paddingView;
    txtName.leftViewMode = UITextFieldViewModeAlways;

    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtEmail.layer.borderColor = [UIColor colorWithRed:0.110 green:0.624 blue:0.843 alpha:1].CGColor;
    txtEmail.layer.cornerRadius = 5.0f;
    txtEmail.layer.borderWidth = 2.0f;
    txtEmail.leftView = paddingView;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtPhone.layer.borderColor = [UIColor colorWithRed:0.110 green:0.624 blue:0.843 alpha:1].CGColor;
    txtPhone.layer.cornerRadius = 5.0f;
    txtPhone.layer.borderWidth = 2.0f;
    txtPhone.leftView = paddingView;
    txtPhone.leftViewMode = UITextFieldViewModeAlways;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtPass.layer.borderColor = [UIColor colorWithRed:0.110 green:0.624 blue:0.843 alpha:1].CGColor;
    txtPass.layer.cornerRadius = 5.0f;
    txtPass.layer.borderWidth = 2.0f;
    txtPass.leftView = paddingView;
    txtPass.leftViewMode = UITextFieldViewModeAlways;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtConfPass.layer.borderColor = [UIColor colorWithRed:0.110 green:0.624 blue:0.843 alpha:1].CGColor;
    txtConfPass.layer.cornerRadius = 5.0f;
    txtConfPass.layer.borderWidth = 2.0f;
    txtConfPass.leftView = paddingView;
    txtConfPass.leftViewMode = UITextFieldViewModeAlways;
    
    btnSignUp.layer.cornerRadius = 5.0f;

}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

@end
