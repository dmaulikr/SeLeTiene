//
//  RememberViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "RememberViewController.h"

@interface RememberViewController ()

@end

@implementation RememberViewController
@synthesize txtEmail,btnRemember;

- (void)viewDidLoad {
    [super viewDidLoad];
    txtEmail.layer.borderColor = [UIColor colorWithRed:0.110 green:0.624 blue:0.843 alpha:1].CGColor;
    txtEmail.layer.cornerRadius = 5.0f;
    txtEmail.layer.borderWidth = 2.0f;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtEmail.leftView = paddingView;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    
    
    btnRemember.layer.cornerRadius = 5.0f;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

// Text METHODS DELEGATE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtEmail resignFirstResponder];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Paso por aca");
    textView.layer.borderColor = [UIColor redColor].CGColor;
    int yPos = textView.frame.origin.y;
    CGRect frame = self.view.frame;
    frame.origin.y = -(yPos - ((self.view.frame.size.height - 216) - 60));
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.frame = frame;
    [UIView commitAnimations];
}

@end
