//
//  RememberViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/7/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RememberViewController : UIViewController <UITextFieldDelegate>{
    int yPos;
    int sW;
    int sH;
}
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnRemember;
extern int dev;

@end