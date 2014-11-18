//
//  EditAccountViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/11/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
#import "User.h"
#import "JOAlert.h"
#import "APIManager.h"

@interface EditAccountViewController : UIViewController <UITextFieldDelegate,MenuViewDelegate,APIManagerDelegate>{
    int yPos;
    int sW;
    int sH;
    CATransition *transition;
    JOAlert *alert;
    APIManager *APIManagerClass;
}
@property (weak, nonatomic) User *edituser;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtCellPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet MenuView *menuView;

extern int dev;

@end
