//
//  JOAlert.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

@interface JOAlert : UIView

@property (strong,nonatomic) CALayer *lyr;
@property (strong,nonatomic) UIView  *bgTxt;
@property (strong,nonatomic) UILabel *lblMsg;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *tapGesture2;

-(instancetype)initWithTextNFrame:(NSString*)text :(CGRect)frame;
-(void)showAlert;
-(void)dismissAlert;
-(void)setText:(NSString*)text;

@end
