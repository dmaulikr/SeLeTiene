//
//  LoginViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 9/30/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "LoginViewController.h"
#import "InformationViewController.h"
#import "RegisterViewController.h"
#import "LogViewController.h"
#import "ProductsViewController.h"
#import "Connection.h"
#import "JOAlert.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "NVControllerGeneric.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    self.btnOffer.titleLabel.numberOfLines = 2;
    self.btnOffer.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnOffer.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    Connection* conn = [[Connection alloc] init];
    [conn openDB];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logged:) name:@"logged" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (IBAction)getInformation:(id)sender {
    NSLog(@"Funciona Boton");
}
- (IBAction)signIn:(id)sender {
    LogViewController *lVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:lVC animated:NO];
}
- (IBAction)loginFb:(id)sender {
    ProductsViewController *PVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProdView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:PVC animated:NO];
}
- (IBAction)signUp:(id)sender {
    RegisterViewController *RVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:RVC animated:NO];
}
- (IBAction)getInfo:(id)sender {
    InformationViewController *iVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:iVC animated:NO];
}
- (IBAction)loginFacebook:(id)sender {
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        [FBSession.activeSession closeAndClearTokenInformation];
    } else {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile,email"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
             
             
         }];
    }
}




- (void)logged:(NSNotification*)notification{
    NVControllerGeneric *tmp = (NVControllerGeneric*)[self.storyboard instantiateViewControllerWithIdentifier:@"NVLogged"];
    tmp.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:tmp animated:YES completion:nil];
}



@end