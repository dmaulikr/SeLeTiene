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
    txtComment.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtComment.layer.borderWidth = 1.0f;
    
    txtCapac.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtCapac.layer.borderWidth = 1.0f;
    
    btnType.layer.borderWidth = 1.0f;
    btnType.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    int xVal = btnType.bounds.size.width  - 10;
    int yVal = btnType.bounds.size.height - 20;
    
    UIImage *image = [UIImage imageNamed:@"btnArr"];
    UIImageView *imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(xVal-13, yVal/2, 13, 20)];
    [imgArr setImage:image];
    [btnType addSubview:imgArr];
    
    txtComment.contentInset = UIEdgeInsetsMake(30,0,0,0);
    txtCapac.contentInset = UIEdgeInsetsMake(30,0,0,0);
    txtCapac.delegate = self;
    txtComment.delegate = self;
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
    frame.origin.y = 64;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.layer.borderColor = [UIColor colorWithRed:0.039 green:0.337 blue:0.643 alpha:1].CGColor;
    NSLog(@"int %f", textView.frame.origin.y);
    yPos = textView.frame.origin.y + 71;
    NSLog(@"int %d", yPos);
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

@end
