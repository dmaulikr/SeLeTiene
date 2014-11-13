//
//  LogViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "NVControllerGeneric.h"
#import "LogViewController.h"
#import "APIManager.h"
#import "Connection.h"

@interface LogViewController ()

@end

@implementation LogViewController
@synthesize txtEmail,txtPassword,btnSignIn,alert;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    txtPassword.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtPassword.layer.cornerRadius = 5.0f;
    txtPassword.layer.borderWidth = 2.0f;
    txtPassword.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    sH = [[UIScreen mainScreen] bounds].size.height;
    txtEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtEmail.layer.cornerRadius = 5.0f;
    txtEmail.layer.borderWidth = 2.0f;
    txtEmail.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtPassword.leftView = paddingView;
    txtPassword.leftViewMode = UITextFieldViewModeAlways;
    
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtEmail.leftView = paddingView;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    
    btnSignIn.layer.cornerRadius = 5.0f;
    
    APIManagerClass = [[APIManager alloc]init];
    APIManagerClass.delegate = self;
    
    alert = [[JOAlert alloc]initWithTextNFrame:@"" :CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

- (void) percentageDownloaded:(double)dataDownloaded{

}


-(void) loadedImage:(UIImage *)imageLoaded{
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}


#pragma TEXTVIEW METHODS DELEGATE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
    textField.layer.borderColor = [UIColor colorWithRed:0.039 green:0.337 blue:0.643 alpha:1].CGColor;
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

- (IBAction)doLogin:(id)sender {
    btnSignIn.enabled = false;
    if ([self validate]) {
        [APIManagerClass loginEmail:txtEmail.text :txtPassword.text];
    }else{
        [self.view addSubview:alert];
        [alert setText:@"Revise los campos"];
        [alert showAlertAutoDismiss];
        btnSignIn.enabled = true;
    }
}


-(BOOL) validate{
    BOOL val = true;
    if([self.txtEmail.text isEqualToString:@""]||![self validateEmail:self.txtEmail.text]){
        self.txtEmail.layer.borderColor = [UIColor colorWithRed:0.620 green:0.239 blue:0.165 alpha:1].CGColor;
        self.txtEmail.layer.borderWidth = 1.0f;
        val = false;
    }
    if([self.txtPassword.text isEqualToString:@""]){
        self.txtPassword.layer.borderColor = [UIColor colorWithRed:0.620 green:0.239 blue:0.165 alpha:1].CGColor;
        self.txtPassword.layer.borderWidth = 1.0f;
        val = false;
    }
    return val;
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text length] > 25) {
        textField.text = [textField.text substringToIndex:25-1];
        return NO;
    }
    return YES;
}

#pragma API Delegate

- (void) loaded:(BOOL)checker :(NSString *)msg :(NSString*)tokenR{
    if (!checker) {
        [self.view addSubview:alert];
        [alert setText:msg];
        [alert showAlert];
        btnSignIn.enabled = true;
    }else{
        token = tokenR;
        NVControllerGeneric *tmp = (NVControllerGeneric*)[self.storyboard instantiateViewControllerWithIdentifier:@"NVLogged"];
        tmp.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:tmp animated:YES completion:nil];
        
    }
}

@end
