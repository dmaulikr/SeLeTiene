//
//  ProductDetailViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/5/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "APIManager.h"
#import "Offer/OfferViewController.h"
#import "AccountViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
@synthesize imgProduct,btnContact,lblTitleProduct,lblUserProduct,DescProduct,viewMenu,tstBtn,btnFb,btnTw,lblPhone,lblCell,download,favBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    APIManager *test = [[APIManager alloc]init];
    test.delegate = self;
    [test rememberPass:@"Test"];
    
    download = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    download.frame = CGRectMake(0, 0, self.view.bounds.size.width, 20);
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    download.transform = transform;
    download.progress = 0.0;
    [self.view addSubview:download];
    
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
    
    transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    viewMenu.delegate = self;
    [viewMenu setButton:1];
    
    NSLog(@"x= %f w= %f",imgProduct.center.x, imgProduct.frame.size.width);
    int posX = (imgProduct.frame.size.width/2 + imgProduct.center.x)-25;
    int posY = imgProduct.frame.origin.y -1;
    favBtn = [[UIButton alloc] initWithFrame:CGRectMake(posX, posY, 30, 47)];
    [favBtn setBackgroundImage:[UIImage imageNamed:@"btnFavorite_off"] forState:UIControlStateNormal];
    [self.view addSubview:favBtn];
    
    
}


- (IBAction)btnContact:(id)sender {
    int screenVal=imgProduct.bounds.size.height + 261;
    if (screenVal > self.view.bounds.size.height) {
        POPSpringAnimation *scl1 = [POPSpringAnimation animation];
        scl1.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
        scl1.toValue = [NSValue valueWithCGPoint:CGPointMake(imgProduct.center.x, imgProduct.center.y - 20)];
        [scl1 setValue:@"toCenter2" forKey:@"animName"];
        scl1.springBounciness = 10;
        scl1.springSpeed = 10;
        [imgProduct pop_addAnimation:scl1 forKey:@"toCenter2"];
        
        POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scl.duration = 0.15;
        scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scl.delegate = self;
        [scl setValue:@"toScale" forKey:@"animName"];
        scl.toValue =[NSValue valueWithCGPoint:CGPointMake(0.7f, 0.7f)];
        [imgProduct pop_addAnimation:scl forKey:@"toScale"];
    }else{
        [self imgAnimated];
    }
}


-(void) imgAnimated {
    x = imgProduct.center.y+(imgProduct.bounds.size.height/2)+10;
    z = 60+x;
    s = 121;
    s = s > 300 ? 300 : s;
    
    btnTw = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 130, 40)];
    btnTw.center = CGPointMake(btnContact.center.x, z);
    btnTw.backgroundColor = [UIColor colorWithRed:0.000 green:0.333 blue:0.651 alpha:1];
    btnTw.layer.cornerRadius = 5.0f;
    btnTw.alpha = 0.0f;
    [btnTw setTitle:@"Twitter" forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageNamed:@"btnTws"];
    UIImageView *imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(10,13,20, 16)];
    [imgArr setImage:image];
    [btnTw addSubview:imgArr];
    [btnTw setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.view addSubview:btnTw];
    
    btnFb = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 130, 40)];
    btnFb.center = CGPointMake(btnContact.center.x, z);
    btnFb.backgroundColor = [UIColor colorWithRed:0.000 green:0.333 blue:0.651 alpha:1];
    btnFb.layer.cornerRadius = 5.0f;
    btnFb.alpha = 0.0f;
    [btnFb setTitle:@"Facebook" forState:UIControlStateNormal];
    
    image = [UIImage imageNamed:@"btnFbs"];
    imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(10,13,13, 13)];
    [imgArr setImage:image];
    [btnFb addSubview:imgArr];
    [btnFb setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.view addSubview:btnFb];
    
    [btnContact setTitle:@"" forState:UIControlStateNormal];
    tstBtn = [[UIView alloc]initWithFrame:btnContact.frame];
    tstBtn.backgroundColor = [UIColor colorWithRed:0.263 green:0.596 blue:0.804 alpha:1];
    tstBtn.layer.cornerRadius = btnContact.layer.cornerRadius;
    [self.view addSubview:tstBtn];
    btnContact.alpha = 0.0f;
    lblTitleProduct.alpha = 0.0f;
    lblUserProduct.alpha = 0.0f;
    
    POPBasicAnimation *toGreen = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    toGreen.duration = 0.15;
    toGreen.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    toGreen.delegate = self;
    [toGreen setValue:@"toGreen" forKey:@"animName"];
    toGreen.toValue = @(0);
    [DescProduct pop_addAnimation:toGreen forKey:@"toGreen"];

}


- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    if (finished) {
        if ([[anim valueForKey:@"animName"] isEqualToString:@"toScale"]) {
            [self imgAnimated];
        }
        if ([[anim valueForKey:@"animName"] isEqualToString:@"toGreen"]) {
            [self enlarge];
        }else {
            if([[anim valueForKey:@"animName"] isEqualToString:@"enlarge"]) {
                [self imagesInformation];
            }else{
                if([[anim valueForKey:@"animName"] isEqualToString:@"toAlpha"]) {
                    [self setData];
                }
            }
        }
    }
}

-(void)enlarge{
    POPBasicAnimation *toGreen = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBounds];
    toGreen.duration = 0.3;
    toGreen.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    toGreen.delegate = self;
    [toGreen setValue:@"enlarge" forKey:@"animName"];
    toGreen.toValue =  [NSValue valueWithCGRect:CGRectMake(0, 0, btnContact.bounds.size.width, s)];
    [tstBtn pop_addAnimation:toGreen forKey:@"enlarge"];

    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(tstBtn.center.x, z)];
    [springAnimation setValue:@"toCenter" forKey:@"animName"];
    springAnimation.springBounciness = 10;
    springAnimation.springSpeed = 10;
    [tstBtn pop_addAnimation:springAnimation forKey:@"toCenter"];
}

-(void)imagesInformation{
    UIImage *bg = [UIImage imageNamed:@"bgContact"];
    UIImageView *tmp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 121)];
    tmp.image = bg;
    tmp.alpha = 0.0f;
    [tstBtn addSubview:tmp];
    
    POPBasicAnimation *toGreen = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    toGreen.duration = 0.15;
    toGreen.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    toGreen.delegate = self;
    [toGreen setValue:@"toAlpha" forKey:@"animName"];
    toGreen.toValue = @(1);
    [tmp pop_addAnimation:toGreen forKey:@"toAlpha"];
}

-(void)setData{
    lblPhone = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 230, 40)];
    [lblPhone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lblPhone setTitle:@"2237204" forState:UIControlStateNormal];
    lblPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [tstBtn addSubview:lblPhone];
    
    lblCell = [[UIButton alloc] initWithFrame:CGRectMake(50, 40, 230, 40)];
    [lblCell setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [lblCell setTitle:@"3145295322" forState:UIControlStateNormal];
    lblCell.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [tstBtn addSubview:lblCell];
    
    UITextField *lblEmail = [[UITextField alloc] initWithFrame:CGRectMake(50, 80, 230, 40)];
    [lblEmail setTextColor:[UIColor whiteColor]];
    [lblEmail setEnabled:NO];
    lblEmail.text = @"jroz9105@gmail.com";
    [tstBtn addSubview:lblEmail];
    
    int fX = tstBtn.center.x;
    int fY = z;
    int sH = tstBtn.bounds.size.height/2;
    
    POPSpringAnimation *sA0 = [POPSpringAnimation animation];
    sA0.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    sA0.toValue = @(1);
    [sA0 setValue:@"toAlpha1" forKey:@"animName"];
    [btnTw pop_addAnimation:sA0 forKey:@"toAlpha1"];
    
    POPSpringAnimation *sA00 = [POPSpringAnimation animation];
    sA00.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    sA00.toValue = @(1);
    [sA00 setValue:@"toAlpha2" forKey:@"animName"];
    [btnFb pop_addAnimation:sA00 forKey:@"toAlpha2"];
    
    
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    sA1.toValue = [NSValue valueWithCGPoint:CGPointMake(fX-70, fY+sH+30)];
    [sA1 setValue:@"toCenter1" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [btnTw pop_addAnimation:sA1 forKey:@"toCenter1"];

    POPSpringAnimation *sA2 = [POPSpringAnimation animation];
    sA2.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    sA2.toValue = [NSValue valueWithCGPoint:CGPointMake(fX+70, fY+sH+30)];
    [sA2 setValue:@"toCenter2" forKey:@"animName"];
    sA2.springBounciness = 10;
    sA2.springSpeed = 10;
    [btnFb pop_addAnimation:sA2 forKey:@"toCenter2"];
    
    [lblCell addTarget:self action:@selector(callPhone:) forControlEvents: UIControlEventTouchUpInside];
    [lblPhone addTarget:self action:@selector(callPhone:) forControlEvents: UIControlEventTouchUpInside];
    [btnTw addTarget:self action:@selector(shareTw:) forControlEvents: UIControlEventTouchUpInside];
    [btnFb addTarget:self action:@selector(shareFb:) forControlEvents: UIControlEventTouchUpInside];
}



- (void) percentageDownloaded:(double)dataDownloaded{
    download.progress = dataDownloaded;
    if (download.progress == 1.0) {
        download.tintColor = [UIColor colorWithRed:0.490 green:0.773 blue:0.482 alpha:1];
    }
}


-(void) loadedImage:(UIImage *)imageLoaded{
    self.imgProduct.image = imageLoaded;
}

-(IBAction)callPhone:(id)sender{
    UIButton *phone = sender;
    NSString *pn = [@"tel:" stringByAppendingString:phone.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pn]];
}

-(IBAction)shareTw:(id)sender{
    NSLog(@"TW...");
}

-(IBAction)shareFb:(id)sender{
    NSLog(@"Fb...");
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

#pragma MENU DELEGATE

- (void) fiendView{
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void) addView{
    OfferViewController *oVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OfferView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:oVC animated:NO];
}
- (void) profileView{
    AccountViewController *aVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:aVC animated:NO];
}

@end
