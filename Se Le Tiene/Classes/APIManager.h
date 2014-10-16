//
//  APIManager.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "User.h"
#import "Product.h"


@class APIManager;

@protocol APIManagerDelegate <NSObject>
@optional
- (void) percentageDownloaded:(double)dataDownloaded;
- (void) loadedImage:(UIImage*)imageLoaded;
- (void) loaded:(BOOL)checker :(NSString*)msg;
@end

@interface APIManager : NSObject <NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *apiData;
    NSMutableData *_responseData;
    NSString *URLAPI;
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

@property (nonatomic, weak) id <APIManagerDelegate> delegate;

@end
