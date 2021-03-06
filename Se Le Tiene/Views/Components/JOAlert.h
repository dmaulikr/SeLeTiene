//
//  JOAlert.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>


@class JOAlert;

@protocol JOAlertDelegate <NSObject>
@optional
- (void) alertClosed;

@end

@interface JOAlert : UIView

@property (strong,nonatomic) CALayer *lyr;
@property (strong,nonatomic) UIView  *bgTxt;
@property (strong,nonatomic) UILabel *lblMsg;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *tapGesture2;
@property (strong,nonatomic) UIImageView *animationView;
@property bool gestures;

-(instancetype)initWithAnimFrame :(CGRect)frame;
-(instancetype)initWithTextNFrame:(NSString*)text :(CGRect)frame;
-(void)showAlert;
-(void)showAlertAnim;
-(void)dismissAlert;
-(void)dismissAlertAnim;
-(void)setText:(NSString*)text;
-(void)showAlertAutoDismiss;

@property (nonatomic, weak) id <JOAlertDelegate> delegate;

@end
