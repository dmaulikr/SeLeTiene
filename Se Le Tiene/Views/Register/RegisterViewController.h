//
//  RegisterViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOAlert.h"
#import "APIManager.h"

@interface RegisterViewController : UIViewController <APIManagerDelegate>{
    int yPos;
    int sW;
    int sH;
    APIManager *APIManagerClass;
    JOAlert *loader;
}
extern int dev;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtPass;
@property (weak, nonatomic) IBOutlet UITextField *txtConfPass;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong,nonatomic) JOAlert *alert;

@end
