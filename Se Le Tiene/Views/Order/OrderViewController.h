//
//  OrderViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/9/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController

extern int order;
@property (weak, nonatomic) IBOutlet UIButton *btnCal;
@property (weak, nonatomic) IBOutlet UIButton *btnUbi;
@property (weak, nonatomic) IBOutlet UIButton *btnAZPro;
@property (weak, nonatomic) IBOutlet UIButton *btnAZOfr;
@property (weak, nonatomic) IBOutlet UIButton *btnOrder;
@end
