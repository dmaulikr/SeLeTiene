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
        yPos += 68;
    } else {
        if([textView isDescendantOfView:self.uiview2]) {
            yPos += 256;
        }
    }
    CGRect frame = self.view.frame;
    if(dev ==1 && yPos >= (sH - 328) - 50){
        frame.origin.y = 160;
    }else{
        if (dev ==2 && yPos >= (sH - 280) - 40 ) {
            frame.origin.y = -(yPos - ((sH - 216) - 60)+71);
        }
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

-(Product*)getActualProduct{
    Product *r = [[Product alloc]init];
    r.nameProduct = self.txtName.text;
    r.descProduct = [NSString stringWithFormat:@"%@ \n %@", self.txtComment.text, self.txtCapac.text];
    return r;
}

@end
