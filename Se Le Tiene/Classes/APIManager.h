//
//  APIManager.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"
#import "Product.h"

@interface APIManager : NSObject <NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *apiData;
    NSMutableData *_responseData;
    NSString *twitterUrl;
    NSString *respo;
    int datos;
    long long total;
}


-(UIImage*) getImageTest;

-(BOOL)loginEmail:(NSString*)userEmail :(NSString*)userPass;
-(BOOL)rememberPass:(NSString*)userEmail;
-(void)logout;
-(NSString*)signUpUser:(User*)user;
-(NSMutableArray*)getProducts;
-(Product*)getProductDetail:(int)idProduct;


@end
