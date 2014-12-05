//
//  FilterViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "FilterViewController.h"
#import "GenTableViewController.h"
#import "Filter.h"
@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize star1,star2,star3,star4,star5,preN,postN,btnFilter,pkCity,tfWord;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.stars = [[NSMutableArray alloc] initWithCapacity:5];
    [self.stars addObject:star1];
    [self.stars addObject:star2];
    [self.stars addObject:star3];
    [self.stars addObject:star4];
    [self.stars addObject:star5];
    preN = 0;
    self.title = @"Filtrar";
    
    btnFilter.layer.cornerRadius = 5.0f;
    
    tfWord.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tfWord.layer.cornerRadius = 5.0f;
    tfWord.layer.borderWidth = 2.0f;
    
    pkCity.layer.borderWidth = 1.0f;
    pkCity.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    tfWord.leftView = paddingView;
    tfWord.leftViewMode = UITextFieldViewModeAlways;
    tfWord.delegate = self;

    int xVal = pkCity.bounds.size.width  - 10;
    int yVal = pkCity.bounds.size.height - 20;
    
    UIImage *image = [UIImage imageNamed:@"btnArr"];
    UIImageView *imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(xVal-13, yVal/2, 13, 20)];
    [imgArr setImage:image];
    [pkCity addSubview:imgArr];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textView{
    [textView resignFirstResponder];
    return YES;
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setStar:(int)numStars{
    stars = numStars;
    int s = preN==numStars ? 0 : numStars;
    for (int i = 0; i<[self.stars count]; i++) {
        if (i<s) {
            [(UIButton*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"btnStar_on"] forState:UIControlStateNormal];
        }else{
            [(UIButton*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"btnStar"] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)setStarT:(id)sender {
    UIButton *tmp = sender;
    [self setStar:tmp.tag];
    preN = tmp.tag;
}

- (IBAction)applyFilters:(id)sender {
    Filter *tmpFilter = [[Filter alloc] init];
    [tmpFilter setTypeFil:self.serviceSelector.selectedSegmentIndex];
    [tmpFilter setStars:stars];
    [tmpFilter setKeyWord:tfWord.text];
    [tmpFilter setFilter];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


// Text METHODS DELEGATE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [tfWord resignFirstResponder];
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
    int yPos = textField.frame.origin.y;
    CGRect frame = self.view.frame;
    frame.origin.y = -(yPos - ((self.view.bounds.size.height - 216) - 60));
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.frame = frame;
    [UIView commitAnimations];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GenTableViewController *tmpView = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"getCities"]) {
        NSLog(@"Getting Cities");
        tmpView.modeTable= 1;
    }
}


@end
