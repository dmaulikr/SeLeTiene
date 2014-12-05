//
//  Product.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Provider.h"

@interface Product : NSObject


@property (nonatomic, retain) NSString *idProduct;
@property (nonatomic, retain) Provider *providerProduct;
@property (nonatomic, retain) NSString *descProduct;
@property (nonatomic, retain) NSString *nameProduct;
@property (nonatomic, retain) UIImage *imageProduct;
@property (nonatomic, retain) NSString *scoreProduct;
@property (nonatomic, retain) NSURL *imgProduct;


-(NSURL*) getImageURL;
-(int) getScore;


@end
