//
//  OfferViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewOffer.h"
#import "APIManager.h"

@interface OfferViewController : UIViewController <APIManagerDelegate>{
    CATransition *transition;
    APIManager *APIManagerclass;
    Product *t;
}


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;

@property (strong,nonatomic) IBOutlet UIImageView *imgProduct;

@property (weak, nonatomic) IBOutlet UIButton *btnPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnOffer;

@property (nonatomic, strong) ContainerViewOffer *containerViewController;

@end
