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

@interface RegisterViewController : UITableViewController <APIManagerDelegate>{
    int yPos;
    int sW;
    int sH;
    APIManager *APIManagerClass;
    JOAlert *loader;
    BOOL keybOpened;
    
    NSString *name;
    NSString *email;
    NSString *phone;
    NSString *idUser;
    NSString *pass;
    NSString *pass2;
}
extern int dev;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong,nonatomic) JOAlert *alert;

@end
