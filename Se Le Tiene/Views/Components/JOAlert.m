//
//  JOAlert.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "JOAlert.h"

@implementation JOAlert
@synthesize lblMsg,lyr,bgTxt,animationView,gestures;

-(instancetype)initWithTextNFrame:(NSString*)text :(CGRect)frame{
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        lyr = [[CALayer alloc]init];
        lyr.frame = frame;
        lyr.backgroundColor = [UIColor blackColor].CGColor;
        lyr.opacity = 0.0;
        [self.layer addSublayer:lyr];
        
        bgTxt = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-270)/2, ((frame.size.height-80)/2)-50, 270, 80)];
        bgTxt.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.7f];
        bgTxt.layer.cornerRadius = 5;
        bgTxt.layer.shadowColor = [UIColor blackColor].CGColor;
        bgTxt.layer.shadowOffset = CGSizeMake(0, 0);
        bgTxt.layer.shadowOpacity = 0.7;
        bgTxt.layer.shadowRadius = 7;
        bgTxt.alpha = 0.0;
        
        [self addSubview:bgTxt];
        
        lblMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 80)];
        lblMsg.text = text;
        lblMsg.textAlignment = NSTextAlignmentCenter;
        lblMsg.numberOfLines = 0;
        [bgTxt addSubview:lblMsg];
        
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        self.tapGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap2:)];
        [self addGestureRecognizer:self.tapGesture];
        [self addGestureRecognizer:self.tapGesture2];
        gestures = true;
    }
    return self;
}



-(instancetype)initWithAnimFrame :(CGRect)frame{
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        lyr = [[CALayer alloc]init];
        lyr.frame = frame;
        lyr.backgroundColor = [UIColor blackColor].CGColor;
        lyr.opacity = 0.0;
        [self.layer addSublayer:lyr];
        
        NSArray *animationArray=[NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"fr-01.png"],
                                 [UIImage imageNamed:@"fr-02.png"],
                                 [UIImage imageNamed:@"fr-03.png"],
                                 [UIImage imageNamed:@"fr-04.png"],
                                 nil];
        animationView=[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-69)/2, ((frame.size.height-44)/2)-160,69,44)];
        animationView.backgroundColor=[UIColor clearColor];
        animationView.animationImages=animationArray;
        animationView.animationDuration=1.5;
        animationView.animationRepeatCount=0;
        [animationView startAnimating];
        [self addSubview:animationView];
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        self.tapGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap2:)];
        gestures = true;
    }
    return self;
}


-(void)showAlert{
    POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scl.duration = 0.15;
    scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl.delegate = self;
    [scl setValue:@"alpha1" forKey:@"animName"];
    scl.toValue = @(0.6);
    [lyr pop_addAnimation:scl forKey:@"alpha1"];
    
    POPBasicAnimation *scl2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    scl2.duration = 0.15;
    scl2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl2.delegate = self;
    [scl2 setValue:@"alpha2" forKey:@"animName"];
    scl2.toValue = @(1);
    [bgTxt pop_addAnimation:scl2 forKey:@"alpha2"];
    
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    sA1.toValue = @((self.bounds.size.height/2)-150);
    [sA1 setValue:@"toCenter1" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [bgTxt pop_addAnimation:sA1 forKey:@"toCenter1"];
    [self addGestureRecognizer:self.tapGesture];
    [self addGestureRecognizer:self.tapGesture2];
}
-(void)dismissAlert{
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    sA1.toValue = @(((self.frame.size.height-50)/2)-50);
    [sA1 setValue:@"toCenter2" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [bgTxt pop_addAnimation:sA1 forKey:@"toCenter2"];
    
    POPBasicAnimation *scl2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    scl2.duration = 0.15;
    scl2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl2.delegate = self;
    [scl2 setValue:@"alpha3" forKey:@"animName"];
    scl2.toValue = @(0);
    [bgTxt pop_addAnimation:scl2 forKey:@"alpha3"];
    
    POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scl.duration = 0.15;
    scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl.delegate = self;
    [scl setValue:@"alpha4" forKey:@"animName"];
    scl.toValue = @(0);
    [lyr pop_addAnimation:scl forKey:@"alpha4"];
    [self.delegate alertClosed];
}


-(void)showAlertAnim{
    POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scl.duration = 0.15;
    scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl.delegate = self;
    [scl setValue:@"alpha1" forKey:@"animName"];
    scl.toValue = @(0.6);
    [lyr pop_addAnimation:scl forKey:@"alpha1"];
    
    POPBasicAnimation *scl2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    scl2.duration = 0.15;
    scl2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl2.delegate = self;
    [scl2 setValue:@"alpha2" forKey:@"animName"];
    scl2.toValue = @(1);
    [animationView pop_addAnimation:scl2 forKey:@"alpha2"];
    
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    sA1.toValue = @((self.bounds.size.height/2)-50);
    [sA1 setValue:@"toCenter1" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [animationView pop_addAnimation:sA1 forKey:@"toCenter1"];
}

-(void)dismissAlertAnim{
    NSLog(@"Paso por aca");
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    sA1.toValue = @(((self.frame.size.height-50)/2)-50);
    [sA1 setValue:@"toCenter2" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [animationView pop_addAnimation:sA1 forKey:@"toCenter2"];
    
    POPBasicAnimation *scl2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    scl2.duration = 0.15;
    scl2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl2.delegate = self;
    [scl2 setValue:@"alpha3" forKey:@"animName"];
    scl2.toValue = @(0);
    [animationView pop_addAnimation:scl2 forKey:@"alpha3"];
    
    POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scl.duration = 0.15;
    scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl.delegate = self;
    [scl setValue:@"alpha5" forKey:@"animName"];
    scl.toValue = @(0);
    [lyr pop_addAnimation:scl forKey:@"alpha5"];
    
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    if (gestures){
        [self dismissAlert];
    }
}

- (void)handleTap2:(UISwipeGestureRecognizer *)recognizer {
    if (gestures){
        [self dismissAlert];
    }
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    if (finished) {
        if ([[anim valueForKey:@"animName"] isEqualToString:@"alpha4"]) {
            [self removeFromSuperview];
        }else{
            if ([[anim valueForKey:@"animName"] isEqualToString:@"alpha5"]) {
                [self removeFromSuperview];
            }
        }
    }
}

-(void)setText:(NSString*)text{
    lblMsg.text = text;
}

-(void)showAlertAutoDismiss{
//    gestures = false;
    [self showAlert];
    [self performSelector:@selector(dismissAlert) withObject:nil afterDelay:2];
//    [self dismissAlert];
}



@end
