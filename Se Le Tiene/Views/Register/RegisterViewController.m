//
//  RegisterViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "RegisterViewController.h"
#import "LblTxtTableViewCell.h"
#import "NVControllerGeneric.h"
#import "LogViewController.h"
#import "GenTableViewController.h"
#import "User.h"
#import <Pop/POP.h>


@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize btnSignUp,alert,viewContainer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    
    sH = [[UIScreen mainScreen] bounds].size.height;
    
    btnSignUp.layer.cornerRadius = 5.0f;
    keybOpened = false;
    
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
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.tableView reloadData];
}



// Text METHODS DELEGATE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    switch (textField.tag) {
        case 1:
            name = textField.text;
        break;
        case 2:
            email = textField.text;
        break;
        case 3:
            phone = textField.text;
        break;
        case 4:
            idUser = textField.text;
        break;
        case 5:
            pass = textField.text;
        break;
        case 6:
            pass2 = textField.text;
        break;
        default:
        break;
    }
}



- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (keybOpened) {
        POPSpringAnimation *pop2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        pop2.toValue =  [NSValue valueWithCGRect:CGRectMake(0, 64, 320, self.tableView.frame.size.height+127)];
        [self.tableView pop_addAnimation:pop2 forKey:@"YUju"];
        keybOpened = false;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!keybOpened) {
        POPSpringAnimation *pop2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        pop2.toValue =  [NSValue valueWithCGRect:CGRectMake(0, 64, 320, self.tableView.frame.size.height-127)];
        [self.tableView pop_addAnimation:pop2 forKey:@"YUju"];
        keybOpened = true;
    }
    
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
    NSString *err = [self validate];
    if ([err isEqualToString:@""]) {
        [self.view.superview addSubview:loader];
        [loader showAlertAnim];
        User *tmpUser = [[User alloc] init];

        tmpUser.name        = name;
        //tmpUser.name        = ((LblTxtTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"Cell0"]).textLabel.text;
        tmpUser.email       = email;
        tmpUser.phoneNumber = phone;
        tmpUser._id         = idUser;
        tmpUser.passwordHash = pass;
        tmpUser.cityID = city[@"id"];
        tmpUser.deptoID = depto[@"id"];
        [APIManagerClass signUpUser:tmpUser];
    }else{
        [self.view.superview addSubview:alert];
        [alert setText:err];
        [alert showAlertAutoDismiss];
        btnSignUp.enabled = true;
    }
}


-(NSString*) validate{
    NSString *val = @"";
    if([email isEqualToString:@""]||![self validateEmail:email]){
        val = [NSString stringWithFormat:@"%@Error en email\n",val];
    }
    if([name isEqualToString:@""]){
        val = [NSString stringWithFormat:@"%@Error en nombre\n",val];
    }
    if([idUser isEqualToString:@""]){
        val = [NSString stringWithFormat:@"%@Cédula obligatoria\n",val];
    }
    if([phone isEqualToString:@""]){
        val = [NSString stringWithFormat:@"%@Error en teléfono\n",val];
    }
    if([pass isEqualToString:@""]||![pass isEqualToString:pass2]||[pass2 isEqualToString:@""]||pass.length < 6){
        val = [NSString stringWithFormat:@"%@Error en passwords\n",val];
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
    }else{
        if ([segue.identifier isEqualToString:@"city"]) {
            GenTableViewController *destViewController = segue.destinationViewController;
            destViewController.modeTable = 4;
        }
    }
}

#pragma APIDelegate

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


//TABLE VIEW CONTROLLER
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LblTxtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell%d",indexPath.row] forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            if (name) {
                cell.txtLabel.text = name;
            }
        break;
        case 1:
            if (email) {
                cell.txtLabel.text = email;
            }
        break;
        case 2:
            if (phone) {
                cell.txtLabel.text = phone;
            }
        break;
        case 3:
            if (idUser) {
                cell.txtLabel.text = idUser;
            }
        break;
        case 4:
            if (depto) {
                [cell.btnLabel setTitle:depto[@"name"] forState:UIControlStateNormal];
            }
        break;
        case 5:
            if (city) {
                [cell.btnLabel setTitle:city[@"name"] forState:UIControlStateNormal];
            }
        break;
        case 6:
            if (pass) {
                cell.txtLabel.text = pass;
            }
        break;
        case 7:
            if (pass2) {
                cell.txtLabel.text = pass2;
            }
        break;
        default:
        break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}




@end
