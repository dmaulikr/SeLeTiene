//
//  RememberViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOAlert.h"
#import "APIManager.h"


@interface RememberViewController : UIViewController <UITextFieldDelegate,APIManagerDelegate>{
    int yPos;
    int sW;
    int sH;
    APIManager *APIManagerClass;
    JOAlert *alert;
    JOAlert *loader;
}
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnRemember;
extern int dev;

@end
