//
//  RememberViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "RememberViewController.h"
#import "LogViewController.h"

@interface RememberViewController ()

@end

@implementation RememberViewController
@synthesize txtEmail,btnRemember;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    txtEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtEmail.layer.cornerRadius = 5.0f;
    txtEmail.layer.borderWidth = 2.0f;
    sH = [[UIScreen mainScreen] bounds].size.height;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtEmail.leftView = paddingView;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    txtEmail.layer.backgroundColor = [UIColor whiteColor].CGColor;
    btnRemember.layer.cornerRadius = 5.0f;
    
    alert = [[JOAlert alloc]initWithTextNFrame:@"" :CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    loader = [[JOAlert alloc]initWithAnimFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    APIManagerClass = [[APIManager alloc] init];
    APIManagerClass.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

// Text METHODS DELEGATE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtEmail resignFirstResponder];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text length] > 35) {
        textField.text = [textField.text substringToIndex:35];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void) returnResponse:(NSString *)msg :(id)response{
    [self.view.superview addSubview:alert];
    [alert setText:msg];
    [loader dismissAlert];
    [alert showAlertAutoDismiss];
    [self performSelector:@selector(redirectLogin) withObject:nil afterDelay:1.5];
}

-(void) redirectLogin{
    LogViewController *lVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [self.navigationController pushViewController:lVC animated:YES];
}

- (IBAction)remember:(id)sender {
    btnRemember.enabled = false;
    if ([self validate]) {
        [self.view.superview addSubview:loader];
        [loader showAlertAnim];
        [APIManagerClass rememberPass:txtEmail.text];
    }else{
        [self.view.superview addSubview:alert];
        [alert setText:@"Ingrese un email"];
        [alert showAlertAutoDismiss];
        btnRemember.enabled = true;
    }
}

-(BOOL) validate{
    BOOL val = true;
    if([txtEmail.text isEqualToString:@""]||![self validateEmail:txtEmail.text]){
        val = false;
    }
    return val;
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

@end
