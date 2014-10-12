//
//  EditAccountViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/11/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "EditAccountViewController.h"

@interface EditAccountViewController ()

@end

@implementation EditAccountViewController
@synthesize btnSave,menuView,txtCellPhone,txtEmail,txtName,txtPhone;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Editar";
    txtPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtCellPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnSave.layer.cornerRadius = 5.0f;
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
