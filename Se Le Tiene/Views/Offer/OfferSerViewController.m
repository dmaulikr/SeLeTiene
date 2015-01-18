//
//  OfferSerViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "OfferSerViewController.h"
#import "GenTableViewController.h"

@interface OfferSerViewController ()

@end

@implementation OfferSerViewController
@synthesize txtCapac,txtComment,btnType;


- (void)viewDidLoad {
    [super viewDidLoad];
    sH = [[UIScreen mainScreen] bounds].size.height;
    
    self.txtName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.txtName.layer.borderWidth = 1.0f;
    self.txtName.backgroundColor = [UIColor whiteColor];
    
    UIView *vil = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 20)];
    self.txtName.leftViewMode = UITextFieldViewModeAlways;
    self.txtName.leftView = vil;
    
    txtCapac.delegate = self;
    txtComment.delegate = self;
    
    self.uiview1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.uiview1.layer.borderWidth = 1.0f;
    self.uiview2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.uiview2.layer.borderWidth = 1.0f;
    
    self.txtCapac.layer.borderColor = [UIColor clearColor].CGColor;
    self.txtComment.layer.borderColor = [UIColor clearColor].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

// Text METHODS DELEGATE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtCapac resignFirstResponder];
    [txtComment resignFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
    textView.layer.borderColor = [UIColor colorWithRed:0.039 green:0.337 blue:0.643 alpha:1].CGColor;
    yPos = textView.frame.origin.y + 71;
    if([textView isDescendantOfView:self.uiview1]) {
        yPos = self.uiview1.frame.origin.y;
    } else {
        if([textView isDescendantOfView:self.uiview2]) {
            yPos = self.uiview2.frame.origin.y;
        }
    }
    CGRect frame = self.view.frame;
    NSLog(@"yPos=%d SH =%d %f %f", yPos,sH,self.view.frame.origin.x, self.view.frame.size.height);
    
    if(yPos+71 >= (sH - 300) - 50){
        frame.origin.y = (self.view.frame.origin.y - yPos);
    }
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textView{
    [textView resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GenTableViewController *tmpView = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"getTypeS"]) {
        tmpView.modeTable= 3;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(Product*)getActualProduct{
    Product *r = [[Product alloc]init];
    r.nameProduct = self.txtName.text;
    r.descProduct = [NSString stringWithFormat:@"%@ \n %@", self.txtComment.text, self.txtCapac.text];
    return r;
}



@end
