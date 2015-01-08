//
//  OfferSerViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferSerViewController : UIViewController <UITextViewDelegate>{
    int yPos;
    int sW;
    int sH;
}

@property (weak, nonatomic) IBOutlet UIButton *btnType;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UITextView *txtComment;
@property (weak, nonatomic) IBOutlet UITextView *txtCapac;
@property (weak, nonatomic) IBOutlet UIView *uiview1;
@property (weak, nonatomic) IBOutlet UIView *uiview2;


extern int dev;

@end
