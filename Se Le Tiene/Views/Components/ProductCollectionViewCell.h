//
//  ProductCollectionViewCell.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stars.h"

@interface ProductCollectionViewCell : UICollectionViewCell

@property (weak,nonatomic) IBOutlet UIImageView* imgProduct;
@property (weak,nonatomic) IBOutlet UILabel* lblNameProduct;
@property (weak,nonatomic) IBOutlet UILabel* lblNameUser;
@property (weak,nonatomic) IBOutlet stars* strs;


@end
