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
#import "Connection.h"

@interface ProductTableViewController : UITableViewController <APIManagerDelegate>{
    APIManager *APIManagerClass;
    JOAlert *alert;
    NSMutableArray *favList;
    NSString* filter;
    NSString* order;
    int mode;
    Connection *conn;
    NSMutableArray *recList;
}

extern NSString *orderStr;
extern NSString *filterStr;
extern NSMutableArray *productsArray;
extern NSString *orderStr;
extern NSString *filterStr;

@property int mode;
@property (strong,nonatomic) IBOutlet UITableView *table;

@end
