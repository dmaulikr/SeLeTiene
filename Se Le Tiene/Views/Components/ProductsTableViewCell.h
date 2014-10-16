//
//  ProductsTableViewCell.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/3/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stars.h"

@interface ProductsTableViewCell : UITableViewCell


@property (weak,nonatomic) IBOutlet UIImageView* imgProduct;
@property (weak,nonatomic) IBOutlet UILabel* lblNameProduct;
@property (weak,nonatomic) IBOutlet UILabel* lblNameUser;
@property (weak,nonatomic) IBOutlet UILabel* lblDescProduct;
@property (weak,nonatomic) IBOutlet stars* strs;

@end
