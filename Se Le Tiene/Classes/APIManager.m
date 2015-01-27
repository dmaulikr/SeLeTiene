//
//  APIManager.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "APIManager.h"
#import "Product.h"
#import "Connection.h"
#import "User.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation APIManager

-(id)init{
    self = [super init];
    if (self) {
      // URLAPI = @"http://api.seletiene.olinguito.com.co/SeLeTiene.svc/";
        URL = @"http://seletiene.cloudapp.net/";
//        URL =@"http://200.119.110.136:81/seletienea/";
        URLAPI = [NSString stringWithFormat:@"%@api/",URL];
        conn = [[Connection alloc] init];
        [conn openDB];
    }
    return self;
}

-(void)loginEmail:(NSString*)userEmail :(NSString*)userPass{
    
    NSDictionary* jsonDict = @{ @"grant_type": @"password",
                                @"username": userEmail,
                                @"password": userPass};
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"Dict de Login:%@", jsonString);
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    [operationManager POST:[NSString stringWithFormat:@"%@token",URL]  parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Exito: %@", [responseObject objectForKey:(@"access_token")]);
        token =[responseObject objectForKey:(@"access_token")];
        [conn createSession:token];
        [self.delegate loaded:true :@"Revise sus datos" :@""];
    }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", [error description]);
           [self.delegate loaded:false :@"Revise sus datos" :@""];
    }];

}


-(void)signUpUserFB{
    [FBRequestConnection startWithGraphPath:@"me?fields=id,name,email" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userDic = @{@"email":result[@"email"],
                                      @"token":[[FBSession activeSession] accessTokenData].accessToken
                                      };
            NSLog(@"Login data: %@", userDic);
            //[self performPost:@"Account/FacebookLogin" :token :userDic :@"Logeado correctamente" :@"Ocurrio un error al loggear"];
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDic options:0 error:nil];
            NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
            NSLog(@"Dict:%@", jsonString);
            AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
            operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
            //    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
            [operationManager POST:[NSString stringWithFormat:@"%@Account/FacebookLogin",URLAPI]  parameters:userDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"Exito: %@", [responseObject objectForKey:(@"access_token")]);
                token =[responseObject objectForKey:(@"access_token")];
                [conn createSession:token];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"logged" object:self];
              //  [self.delegate loaded:true :@"Revise sus datos" :@""];
            }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               NSLog(@"Error: %@", [error description]);
                               [self.delegate loaded:false :@"Revise sus datos" :@""];
                           }];
        }
    }];
}

-(void)rememberPass:(NSString*)userEmail{
    //[self getImageTest];
}

-(void)logout{
    token = @"";
    [conn deleteSession];
    [FBSession.activeSession closeAndClearTokenInformation];
}

-(void)signUpUser:(User*)user{
    NSDictionary *userDic = @{
                              //@"key":@"value"
                              @"email":user.email,
                              @"name":user.name,
                              @"password":user.passwordHash,
                              @"phoneNumber":user.phoneNumber,
                              @"UserId":user._id
                              };
    [self performPost:@"Account" :token :userDic :@"Creado correctamente" :@"Ocurrio un error al crear"];
}

-(void)updateUser:(User*)user{
    NSDictionary *userDic = @{
                              //@"key":@"value"
                              @"email":user.email,
                              @"name":user.name,
                              @"phoneNumber":user.phoneNumber,
                              @"mobileNumber":user.mobileNumber
                              };
    [self performPut:@"Account" :token :userDic :@"Actualizado correctamente" :@"Ocurrio un error al crear"];
}


-(void)setFavorite:(int)productServiceId :(BOOL)activate{
    NSDictionary *test;
    if (activate)
        [self performPut:[NSString stringWithFormat:@"ProductServices/Favorite?productServiceId=%d",productServiceId] :token :test :@"Favorito" :@"Ocurrio un error"];
    else
        [self performDelete:[NSString stringWithFormat:@"ProductServices/Favorite?productServiceId=%d",productServiceId] :token :test :@"Eliminado de Favoritos" :@"Ocurrio un error"];
}


-(void)getProducts:(NSString*)filters{
    [self performGet:[NSString stringWithFormat:@"productservices?ignoredpsvalidation=true%@",filters] :token :true];
}

-(void)getProductDetail:(int)idProduct{
    [self performGet:[NSString stringWithFormat:@"productservices/%d",idProduct] :token :false];
}

-(void)getFavorites{
    [self performGet:@"Account/Favorites" :token :true];
}

-(void)getCities{
    [self performGet:@"Departments" :token :true];
}


-(void)getSelfUser{
    [self performGet:@"Account" :token :false];
}


#pragma CONNECTION DELEGATE


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    total = response.expectedContentLength;
    NSLog(@"Expected %lld",response.expectedContentLength);
    //Tamaño de la descarga: %@", response
    apiData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"%@",connection.currentRequest.URL);
    datos += data.length;
    //NSLog(@"Progress %f", datos / (float)total);
    [self.delegate percentageDownloaded: datos / (float)total];
    [apiData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@",connection.currentRequest.URL);
    if ([[NSString stringWithFormat:@"%@",connection.currentRequest.URL] isEqualToString:@"http://imagenestodo.com/wp-content/uploads/2014/05/star_wars_logo.jpg"]) {
        [self.delegate loadedImage:[UIImage imageWithData:apiData]];
    }else{
        NSDictionary *apiResponse = [NSJSONSerialization JSONObjectWithData:apiData options:kNilOptions error:nil];
        NSLog(@"%@",apiResponse);
    }
}

#pragma Manager Methods

-(void) performGet:(NSString*)url :(NSString*)token :(BOOL)list{
    //if (![token isEqualToString:@""]) {
        NSLog(@"Performing Get with URL: %@",[NSString stringWithFormat:@"%@%@",URLAPI,url]);
        AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
        operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //[operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [operationManager GET:[NSString stringWithFormat:@"%@%@",URLAPI,url] parameters:nil
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSLog(@"Sirveee: %@", responseObject);
                          if (list) {
                              [self.delegate returnList:responseObject :url];
                          }else{
                              [self.delegate returnObt:responseObject];
                          }
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Error: %@", [error description]);
                          //[self.delegate loaded:false :@"Revise sus datos" :@""];
                      }
         ];
    //}
}


-(void) performPost:(NSString*)url :(NSString*)token :(NSDictionary*)data :(NSString*)successMsg :(NSString*)failMsg {
    NSLog(@"Performing Post");
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token]  forHTTPHeaderField:@"Authorization"];
    NSLog(@"%@",data);
    [operationManager POST:[NSString stringWithFormat:@"%@%@",URLAPI,url] parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", responseObject);
            [self.delegate returnResponse:successMsg :responseObject];
        }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"Error: %@", [error description]);
                       [self.delegate returnResponse:failMsg :nil];
       }];
}


-(void) performPut:(NSString*)url :(NSString*)token :(NSDictionary*)data :(NSString*)successMsg :(NSString*)failMsg {
    NSLog(@"Performing PUT");
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token]  forHTTPHeaderField:@"Authorization"];
    NSLog(@"%@",data);
    [operationManager PUT:[NSString stringWithFormat:@"%@%@",URLAPI,url] parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success response: %@", responseObject);
        [self.delegate returnResponse:successMsg :nil];
    }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", [error description]);
           [self.delegate returnResponse:failMsg :nil];
           //[self.delegate loaded:false :@"Revise sus datos" :@""];
       }];
}

-(void) performDelete:(NSString*)url :(NSString*)token :(NSDictionary*)data :(NSString*)successMsg :(NSString*)failMsg {
    NSLog(@"Performing DELETE");
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token]  forHTTPHeaderField:@"Authorization"];
    NSLog(@"%@",data);
    [operationManager DELETE:[NSString stringWithFormat:@"%@%@",URLAPI,url] parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success response: %@", responseObject);
        [self.delegate returnResponse:successMsg :nil];
    }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error: %@", [error description]);
                      [self.delegate returnResponse:failMsg :nil];
                      //[self.delegate loaded:false :@"Revise sus datos" :@""];
                  }];
}

-(void)registerProduct:(Product*)product :(int)type{
    NSDictionary *productDic = @{
                              //@"key":@"value"
                              @"Title":product.nameProduct,
                              @"Description":product.descProduct,
                              @"Type":[NSString stringWithFormat:@"%d",type]
                              };
   // NSLog(@"Posteando Producto%@",token);
    [self performPost:@"ProductServices" :token :productDic :@"Creado" :@"Ocurrio un error al crear"];
}


-(void)postImage:(int)idProduct :(UIImage*)imageProduct{
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token]  forHTTPHeaderField:@"Authorization"];
    NSData *imageData = UIImageJPEGRepresentation(imageProduct,1); // image size ca. 50 KB
    [operationManager POST:[NSString stringWithFormat:@"%@/ProductServices/Image?ProductoServicioId=%d",URLAPI,idProduct] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"upload" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success %@", responseObject);
        [self.delegate returnBool:true];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure %@, %@", error, operation.responseString);
       [self.delegate returnBool:false];
    }];
}

-(void)rateStars:(int)stars :(int)idProduct{
    NSLog(@"Stars: %d, id Product %d",stars,idProduct);
    [self performPut:[NSString stringWithFormat:@"ProductServices/Rate?productServiceId=%d&newRating=%d",idProduct,stars] :token :nil :@"Calificado" :@"Ocurrio un error"];
}

@end
