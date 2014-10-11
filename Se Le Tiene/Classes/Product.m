//
//  Product.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)init{
    self = [super init];
    if (self) {
        idProduct = 0;
        namProduct = @"";
        descProduct = @"";
        stars = 0;
        imageProduct = nil;
        
    }
    return self;
}


//GETTERS
-(int)getIdProduct{
    return idProduct;
}
-(NSString*)getNamProduct{
    return namProduct;
}
-(NSString*)getDescProduct{
    return descProduct;
}
-(NSString*)getOfferProduct{
    return offerProduct;
}
-(int) getStars{
    return stars;
}
-(UIImage*) getImageProduct{
    return imageProduct;
}
-(NSURL*)getImageURL{
    return imageURL;
}


//SETTERS
-(void)setIdProduct:(int)idProductN{
    idProduct = idProductN;
}
-(void)setNamProduct:(NSString*)namProductN{
    namProduct = namProductN;
}
-(void)setDescProduct:(NSString*)descProductN{
    descProduct = descProductN;
}
-(void)setStars:(int)starsN{
    stars = starsN;
}
-(void)setImageProduct:(UIImage*)imageProductN{
    imageProduct = imageProductN;
}
-(void)setOfferProduct:(NSString*)offerProductN{
    offerProduct = offerProductN;
}
-(void)setImageURL:(NSURL*)imageURLnew{
    imageURL = imageURLnew;
}
@end
