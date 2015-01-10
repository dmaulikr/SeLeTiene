//
//  EditAccountViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/11/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "EditAccountViewController.h"
#import "OfferViewController.h"

@interface EditAccountViewController ()

@end

@implementation EditAccountViewController
@synthesize btnSave,menuView,txtCellPhone,txtEmail,txtName,txtPhone;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];   
    sH = [[UIScreen mainScreen] bounds].size.height;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.title = @"Editar";
    txtPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtPhone.leftView = paddingView;
    txtPhone.backgroundColor = [UIColor whiteColor];
    txtPhone.leftViewMode = UITextFieldViewModeAlways;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtName.leftView = paddingView;
    [txtName setTextColor:[UIColor lightGrayColor]];
    txtName.leftViewMode = UITextFieldViewModeAlways;
    txtName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtName.backgroundColor = [UIColor whiteColor];
    txtName.enabled = NO;
    txtEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtEmail.leftView = paddingView;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    txtEmail.backgroundColor = [UIColor whiteColor];
    txtCellPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtCellPhone.leftView = paddingView;
    txtCellPhone.backgroundColor = [UIColor whiteColor];
    txtCellPhone.leftViewMode = UITextFieldViewModeAlways;
    btnSave.layer.cornerRadius = 5.0f;
    
    menuView.delegate = self;
    [menuView setButton:3];
    
    transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    txtCellPhone.text = [[NSString stringWithFormat:@"%@",self.edituser.mobileNumber] isEqualToString:@"<null>"]? @"---":self.edituser.mobileNumber;
    txtPhone.text = [[NSString stringWithFormat:@"%@",self.edituser.phoneNumber] isEqualToString:@"<null>"]? @"---":self.edituser.phoneNumber;
    txtEmail.text = self.edituser.email;
    txtName.text = self.edituser.name;
    
    alert = [[JOAlert alloc]initWithTextNFrame:@"" :CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    APIManagerClass = [[APIManager alloc] init];
    APIManagerClass.delegate = self;
}

#pragma DELEGATE METHODS

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtEmail resignFirstResponder];
    [txtName resignFirstResponder];
    [txtCellPhone resignFirstResponder];
    [txtPhone resignFirstResponder];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    yPos = textField.frame.origin.y;
    CGRect frame = self.view.frame;
    if(dev ==1 && yPos >= (sH - 328) - 50){
        frame.origin.y = 160;
    }else{
        if (dev ==2 && yPos >= (sH - 280) - 40 ) {
            frame.origin.y = -(yPos - ((sH - 216) - 60));
        }
    }
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma CUSTOM METHODS

-(IBAction)saveData:(id)sender{
    [txtEmail resignFirstResponder];
    [txtName resignFirstResponder];
    [txtCellPhone resignFirstResponder];
    [txtPhone resignFirstResponder];
    self.edituser.mobileNumber = txtCellPhone.text;
    self.edituser.phoneNumber = txtPhone.text;
    self.edituser.email = txtEmail.text;
    [APIManagerClass updateUser:self.edituser];
    NSLog(@"Updeteando data...");
}


#pragma APIDelegate

- (void) returnResponse:(NSString *)msg{
    [self.view addSubview:alert];
    [alert setText:msg];
    [alert showAlertAutoDismiss];
}



#pragma MENU DELEGATE

- (void) fiendView{
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void) addView{
    OfferViewController *oVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OfferView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:oVC animated:NO];
}
- (void) profileView{
    
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
