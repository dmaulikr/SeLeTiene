//
//  Product.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageProduct = nil;
        self.providerProduct = [[Provider alloc] init];
    }
    return self;
}

-(NSURL*) getImageURL{
    if ([self.urlImage isEqual:(id)[NSNull null]]||[self.urlImage  isEqualToString:@"<null>"]||!self.urlImage) {
        return [NSURL URLWithString:@"http://lorempixel.com/g/190/80/"];
    }else{
        return [NSURL URLWithString:[NSString stringWithFormat:@"http://seletiene.cloudapp.net%@",self.urlImage]];
    }
}

-(int) getScore{
    return [self.scoreProduct intValue];
}

@end
