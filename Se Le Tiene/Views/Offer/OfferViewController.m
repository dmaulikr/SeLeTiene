//
//  OfferViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "OfferViewController.h"

@interface OfferViewController ()

@end

@implementation OfferViewController
@synthesize imgProduct,btnPhoto,btnOffer;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    btnOffer.layer.cornerRadius = 5.0f;
    self.title = @"Ofrecer";
    transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    APIManagerclass = [[APIManager alloc]init];
    APIManagerclass.delegate = self;
    
    alert = [[JOAlert alloc]initWithTextNFrame:@"" :self.view.frame];
    alert.delegate = self;
}

- (IBAction)changeType:(id)sender {
    UISegmentedControl * tmpControl = sender;
    [self.containerViewController swapViewControllers];
    if (tmpControl.selectedSegmentIndex == 0) {
        [btnOffer setTitle:@"Ofrecer Producto" forState:UIControlStateNormal];
    }else{
        [btnOffer setTitle:@"Ofrecer Servicio" forState:UIControlStateNormal];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (IBAction)offerProduct:(id)sender {
    t = [self.containerViewController getProduct];
    //[APIManagerclass postImage:6 :t.imageProduct];
    self.segmented.userInteractionEnabled = false;
    self.btnOffer.userInteractionEnabled = false;
    t = [self.containerViewController getProduct];
    if (self.segmented.selectedSegmentIndex == 0) {
        [APIManagerclass registerProduct:t :0];
    }else{
        [APIManagerclass registerProduct:t :1];
    }
}

- (void) returnResponse:(NSString *)msg :(id)response{
    if ([msg isEqualToString:@"Creado"]) {
        if (self.segmented.selectedSegmentIndex == 0) {
            NSDictionary *key  = (NSDictionary*)response;
            t.imageProduct = [self imageWithImage:t.imageProduct scaledToSize:CGSizeMake(300, 402)];
            [APIManagerclass postImage:[NSString stringWithFormat:@"%@", key[@"id"]].intValue :t.imageProduct];
            [alert setText:@"Subiendo Imagen"];
        }else{
            [alert setText:@"Producto Creado"];
        }
    }else{
        [alert setText:@"Fallo al crear, intente luego"];
    }
    [self.view addSubview:alert];
    [alert showAlert];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void) returnBool:(BOOL)response{
    if (response) {
        [alert setText:@"Producto Creado"];
    }else{
        [alert setText:@"Ocurrio un error"];
    }
}

- (void) alertClosed{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
