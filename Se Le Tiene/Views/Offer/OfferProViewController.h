//
//  OfferProViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

@interface OfferProViewController : UIViewController <UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (strong,nonatomic) IBOutlet UIImageView *imgProduct;
@property (strong,nonatomic) IBOutlet UIButton    *btnAddPic;
@property (strong,nonatomic) IBOutlet UITextView  *txtDesc;
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnSetType;

@property (weak, nonatomic) IBOutlet UITextField *txtName;


@end
