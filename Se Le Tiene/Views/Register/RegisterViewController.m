//
//  RegisterViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "RegisterViewController.h"
#import "NVControllerGeneric.h"
#import "LogViewController.h"
#import "GenTableViewController.h"
#import "User.h"
#import <Pop/POP.h>


@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize txtConfPass,txtEmail,txtName,txtPass,txtPhone,btnSignUp,alert,viewContainer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    sH = [[UIScreen mainScreen] bounds].size.height;
    
    txtName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtName.layer.cornerRadius = 5.0f;
    txtName.layer.borderWidth = 2.0f;
    txtName.leftView = paddingView;
    txtName.leftViewMode = UITextFieldViewModeAlways;
    txtName.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtEmail.layer.cornerRadius = 5.0f;
    txtEmail.layer.borderWidth = 2.0f;
    txtEmail.leftView = paddingView;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtEmail.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    
    txtPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtPhone.layer.cornerRadius = 5.0f;
    txtPhone.layer.borderWidth = 2.0f;
    txtPhone.leftView = paddingView;
    txtPhone.leftViewMode = UITextFieldViewModeAlways;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtPhone.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    txtPass.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtPass.layer.cornerRadius = 5.0f;
    txtPass.layer.borderWidth = 2.0f;
    txtPass.leftView = paddingView;
    txtPass.leftViewMode = UITextFieldViewModeAlways;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtPass.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    txtConfPass.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtConfPass.layer.cornerRadius = 5.0f;
    txtConfPass.layer.borderWidth = 2.0f;
    txtConfPass.leftView = paddingView;
    txtConfPass.leftViewMode = UITextFieldViewModeAlways;
    txtConfPass.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    btnSignUp.layer.cornerRadius = 5.0f;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
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
    [txtConfPass resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtName resignFirstResponder];
    [txtPass resignFirstResponder];
    [txtPhone resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
}



- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    viewContainer.frame = frame;
    [UIView commitAnimations];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor colorWithRed:0.039 green:0.337 blue:0.643 alpha:1].CGColor;
    yPos = textField.frame.origin.y;
    int test = viewContainer.center.y;
    if(yPos >= (sH - 280) - 40){
        test = -yPos+(sH/2);
    }
    POPBasicAnimation *pop = [POPBasicAnimation animation];
    pop.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    pop.fromValue = [NSValue valueWithCGPoint:viewContainer.center];
    pop.toValue = [NSValue valueWithCGPoint:CGPointMake(viewContainer.center.x,test)];
    [viewContainer pop_addAnimation:pop forKey:@"Test"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)SignUpUser:(id)sender {
    btnSignUp.enabled = false;
    if ([self validate]) {
        [self.view addSubview:loader];
        [loader showAlertAnim];
        User *tmpUser = [[User alloc] init];
        tmpUser.name = txtName.text;
        tmpUser.email = txtEmail.text;
        tmpUser.phoneNumber = txtPhone.text;
        tmpUser.passwordHash = txtPass.text;
        [APIManagerClass signUpUser:tmpUser];
    }else{
        [self.view addSubview:alert];
        [alert setText:@"Revise los campos"];
        [alert showAlertAutoDismiss];
        btnSignUp.enabled = true;
    }
}


-(BOOL) validate{
    BOOL val = true;
    if([self.txtEmail.text isEqualToString:@""]||![self validateEmail:self.txtEmail.text]){
        self.txtEmail.layer.borderColor = [UIColor colorWithRed:0.620 green:0.239 blue:0.165 alpha:1].CGColor;
        self.txtEmail.layer.borderWidth = 1.0f;
        val = false;
    }
    if([self.txtName.text isEqualToString:@""]){
        self.txtName.layer.borderColor = [UIColor colorWithRed:0.620 green:0.239 blue:0.165 alpha:1].CGColor;
        self.txtName.layer.borderWidth = 1.0f;
        val = false;
    }
    if([self.txtPhone.text isEqualToString:@""]){
        self.txtPhone.layer.borderColor = [UIColor colorWithRed:0.620 green:0.239 blue:0.165 alpha:1].CGColor;
        self.txtPhone.layer.borderWidth = 1.0f;
        val = false;
    }
    if([self.txtPass.text isEqualToString:@""]||![self.txtPass.text isEqualToString:self.txtConfPass.text]||[self.txtConfPass.text isEqualToString:@""]||self.txtPass.text.length < 6){
        self.txtPass.layer.borderColor = [UIColor colorWithRed:0.620 green:0.239 blue:0.165 alpha:1].CGColor;
        self.txtPass.layer.borderWidth = 1.0f;
        self.txtConfPass.layer.borderColor = [UIColor colorWithRed:0.620 green:0.239 blue:0.165 alpha:1].CGColor;
        self.txtConfPass.layer.borderWidth = 1.0f;
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
    if ([textField.text length] > 35) {
        textField.text = [textField.text substringToIndex:35-1];
        return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"department"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        GenTableViewController *destViewController = segue.destinationViewController;
        destViewController.modeTable = 1;
    }
}


#pragma APIDelegate

- (void) returnResponse:(NSString *)msg :(id)response{
    [self.view addSubview:alert];
    [alert setText:msg];
    [loader dismissAlert];
    [alert showAlertAutoDismiss];
    [self performSelector:@selector(redirectLogin) withObject:nil afterDelay:0.6];
}

-(void) redirectLogin{
    LogViewController *lVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [self.navigationController pushViewController:lVC animated:YES];
}


//TABLE VIEW CONTROLLER
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell%d",indexPath.row] forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}




@end
