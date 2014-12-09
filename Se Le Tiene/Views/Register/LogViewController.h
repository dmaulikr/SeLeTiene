//
//  LogViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"
#import "JOAlert.h"
@interface LogViewController : UIViewController <UITextFieldDelegate,APIManagerDelegate>{
    int yPos;
    int sW;
    int sH;
    APIManager *APIManagerClass;
    JOAlert *loader;
}
extern int dev;
extern NSString* token;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) JOAlert *alert;
@end
