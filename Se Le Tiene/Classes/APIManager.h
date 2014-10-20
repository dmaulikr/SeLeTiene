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
- (void) loaded:(BOOL)checker :(NSString*)msg :(NSString*)tokenR;
- (void) returnResponse:(NSString *)msg;
- (void)returnList:(id)responseObject;
- (void) returnObt:(id)responseObject;


@end

@interface APIManager : NSObject <NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *apiData;
    NSMutableData *_responseData;
    NSString *URLAPI;
    int datos;
    long long total;
    id objReturn;
}

extern NSString* token;
-(void) getImageTest;
-(void)loginEmail:(NSString*)userEmail :(NSString*)userPass;
-(void)rememberPass:(NSString*)userEmail;
-(void)logout;
-(void)signUpUser:(User*)user;
-(void)getProducts:(NSString*)filters;
-(void)getProductDetail:(int)idProduct;
-(void)getFavorites;
-(void)getSelfUser;

@property (nonatomic, weak) id <APIManagerDelegate> delegate;

@end
