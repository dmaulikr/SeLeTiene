//
//  GenTableViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

@interface GenTableViewController : UITableViewController <APIManagerDelegate>


@property (strong,nonatomic) APIManager *APIManagerClass;
@property int modeTable;
@property (strong,nonatomic) NSMutableArray *data;
@property (nonatomic,retain)  NSMutableDictionary *sections;

@end
