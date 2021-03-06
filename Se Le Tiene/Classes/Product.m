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
        return [NSURL URLWithString:@"http://i.imgur.com/A20cNUcl.png"];
    }else{
        //@"http://seletiene.cloudapp.net/ http://200.119.110.136:81/seletienea"
        //return [NSURL URLWithString:[NSString stringWithFormat:@"http://seletiene.cloudapp.net%@",self.urlImage]];
        NSLog(@"%@",[NSString stringWithFormat:@"http://201.245.123.114:8089/seletiene%@",self.urlImage]);
        return [NSURL URLWithString:[NSString stringWithFormat:@"http://201.245.123.114:8089/seletiene%@",self.urlImage]];
    }
}

-(int) getScore{
    return [self.scoreProduct intValue];
}

@end
