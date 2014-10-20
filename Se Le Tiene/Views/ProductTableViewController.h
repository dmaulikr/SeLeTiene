//
//  ProductTableViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"
#import "JOAlert.h"

@interface ProductTableViewController : UITableViewController <APIManagerDelegate>{
    APIManager *APIManagerClass;
    JOAlert *alert;
    NSMutableArray *favList;
}

extern NSMutableArray *productsArray;
@property int mode;

@end
