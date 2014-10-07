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





@end
