//
//  Product.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Product : NSObject{
    int idProduct;
    NSString *namProduct;
    NSString *descProduct;
    NSString *offerProduct;
    int stars;
    UIImage *imageProduct;
    NSURL *imageURL;
}


//GETTERS
-(int)getIdProduct;
-(NSString*)getNamProduct;
-(NSString*)getDescProduct;
-(NSString*)getOfferProduct;
-(int) getStars;
-(UIImage*) getImageProduct;
-(NSURL*)getImageURL;

//SETTERS
-(void)setIdProduct:(int)idProductN;
-(void)setNamProduct:(NSString*)namProductN;
-(void)setDescProduct:(NSString*)descProductN;
-(void)setOfferProduct:(NSString*)offerProductN;
-(void)setStars:(int)starsN;
-(void)setImageProduct:(UIImage*)imageProductN;
-(void)setImageURL:(NSURL*)imageURLnew;






@end
