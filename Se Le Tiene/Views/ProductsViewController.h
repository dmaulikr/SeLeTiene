//
//  ProductsViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsContViewController.h"
#import "ProductTableViewController.h"


@interface ProductsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewLoaded;
@property (strong,nonatomic) ProductsContViewController *GridView;
@property (strong,nonatomic) ProductTableViewController *ListView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeView;


@end
