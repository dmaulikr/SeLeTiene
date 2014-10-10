//
//  ProductDetailViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/5/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
@synthesize imgProduct,btnContact,lblTitleProduct,lblUserProduct,DescProduct,btnMen1,btnMen2,btnMen3,viewMenu,tstBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    

    [imgProduct.layer setShadowOffset:CGSizeMake(0, 3)];
    [imgProduct.layer setCornerRadius:5];
    [imgProduct.layer setShadowOpacity:0.4];
    [imgProduct.layer setShadowRadius:3.0f];
    [imgProduct.layer setShouldRasterize:YES];
    imgProduct.layer.masksToBounds = YES;
    [imgProduct.layer setCornerRadius:10.0f];
    [imgProduct.layer setShadowPath: [[UIBezierPath bezierPathWithRoundedRect:imgProduct.layer.bounds cornerRadius:12.0f] CGPath]];
    
    DescProduct.textAlignment = NSTextAlignmentJustified;
    
    btnContact.layer.cornerRadius = 10.0f;
    
    self.navigationController.title = @"Ofrecer";
    self.title = @"Ofrecer";
    
    
    btnMen1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnMen1.frame = CGRectMake(0, 0, self.viewMenu.bounds.size.width/3, 60);
    [btnMen1 setImage:[UIImage imageNamed:@"btnSearchMenu"] forState:UIControlStateNormal];
    btnMen1.tintColor = [UIColor colorWithRed:0.263 green:0.596 blue:0.804 alpha:1];
    [viewMenu addSubview:btnMen1];
    
    
    btnMen2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnMen2.frame = CGRectMake(self.viewMenu.bounds.size.width/3, 0, self.viewMenu.bounds.size.width/3, 60);
    [btnMen2 setImage:[UIImage imageNamed:@"btnAddMenu"] forState:UIControlStateNormal];
    btnMen2.tintColor = [UIColor whiteColor];
    [viewMenu addSubview:btnMen2];
    
    btnMen3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnMen3.frame = CGRectMake((self.viewMenu.bounds.size.width/3)*2, 0, self.viewMenu.bounds.size.width/3, 60);
    [btnMen3 setImage:[UIImage imageNamed:@"btnUserMenu"] forState:UIControlStateNormal];
    btnMen3.tintColor = [UIColor whiteColor];
    [viewMenu addSubview:btnMen3];
    
}


- (IBAction)btnContact:(id)sender {
    [btnContact setTitle:@"" forState:UIControlStateNormal];
    
    tstBtn = [[UIView alloc]initWithFrame:btnContact.frame];
    //tstBtn.backgroundColor = [UIColor colorWithRed:0.263 green:0.596 blue:0.804 alpha:1];
    
    tstBtn.backgroundColor = [UIColor clearColor];
    
    tstBtn.layer.cornerRadius = btnContact.layer.cornerRadius;
    
    tstBtn.layer.borderWidth = 2;
    tstBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:tstBtn];
    btnContact.alpha = 0.0f;
    lblTitleProduct.alpha = 0.0f;
    lblUserProduct.alpha = 0.0f;
    
    POPBasicAnimation *toGreen = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    toGreen.duration = 0.3;
    toGreen.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    toGreen.delegate = self;
    [toGreen setValue:@"toGreen" forKey:@"animName"];
    toGreen.toValue = @(0);
    [DescProduct pop_addAnimation:toGreen forKey:@"toGreen"];
}


- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    NSLog(@"Aww yeah");
    if (finished) {
        if ([[anim valueForKey:@"animName"] isEqualToString:@"toGreen"]) {
            [self enlarge];
        }
    }
}

-(void)enlarge{
    
    POPBasicAnimation *toGreen = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBounds];
    toGreen.duration = 0.2;
    toGreen.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    toGreen.delegate = self;
    [toGreen setValue:@"enlarge" forKey:@"animName"];
    
    int screenH = self.view.bounds.size.height;
    NSLog(@"%d", screenH);

    
    int xpos1 = imgProduct.center.y;
    NSLog(@"P1: %d",xpos1);
    int xpos2 = imgProduct.bounds.origin.y + imgProduct.bounds.size.height;
    NSLog(@"P2: %d",xpos2);
    
    
    int xpos3 = viewMenu.center.y;
    NSLog(@"P3: %d",xpos3);
    int xpos4 = viewMenu.bounds.origin.y + viewMenu.bounds.size.height;
    NSLog(@"P4: %d",xpos4);
    
    
    int posA = (viewMenu.center.y - 30)- (imgProduct.center.y-(imgProduct.bounds.size.height/2));
    NSLog(@"Chachin %d",posA);
    
    
    int l = ((screenH - (imgProduct.bounds.origin.y)) - imgProduct.bounds.size.height)-10;
    double lm = l/2;
    
    int h = (self.view.bounds.size.height - l)-70;
    toGreen.toValue =  [NSValue valueWithCGRect:CGRectMake(0, 0, btnContact.bounds.size.width, l)];
    [tstBtn pop_addAnimation:toGreen forKey:@"enlarge"];
    
    
    /*POPBasicAnimation *toF = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    toF.duration = 0.2;
    toF.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    toF.delegate = self;
    [toF setValue:@"center" forKey:@"animName"];
    toF.toValue =  [NSValue valueWithCGPoint:CGPointMake(tstBtn.center.x, h+lm)];
    [tstBtn pop_addAnimation:toF forKey:@"center"];*/
    
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(tstBtn.center.x, h+lm)];
    [tstBtn pop_addAnimation:springAnimation forKey:@"center"];
    
    springAnimation.springBounciness = 10;
    springAnimation.springSpeed = 10;
    
}


@end
