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

@implementation APIManager

-(id)init{
    self = [super init];
    if (self) {
      // URLAPI = @"http://api.seletiene.olinguito.com.co/SeLeTiene.svc/";
      //  URLAPI = @"http://se-le-tiene.cloudapp.net/SeLeTiene.svc/";
        URLAPI = @"http://seletiene.cloudapp.net/api/";
    }
    return self;
}

-(void)loginEmail:(NSString*)userEmail :(NSString*)userPass{
    Connection* conn = [[Connection alloc] init];
    [conn openDB];
    
    NSDictionary* jsonDict = @{ @"grant_type": @"password",
                                @"username": userEmail,
                                @"password": userPass};
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"Dict:%@", jsonString);
    
    /*NSError *e;
    NSDictionary *JSON =
    [NSJSONSerialization JSONObjectWithData: [[tst JSONString] dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
*/
    

    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
//    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    NSLog(@"Rquest creado");
    //NSLog(@"%@",dic);
    
    [operationManager POST:@"http://seletiene.cloudapp.net/token"  parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", [responseObject objectForKey:(@"access_token")]);
        //[self.delegate returnResponse:successMsg];
        [self.delegate loaded:true :@"Revise sus datos" :@""];
        [conn createSession:[responseObject objectForKey:(@"access_token")]];
        
    }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", [error description]);
          // [self.delegate returnResponse:failMsg];
           [self.delegate loaded:false :@"Revise sus datos" :@""];
    }];

}

-(void) getImageTest{
    NSURLRequest *apiRequest    = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://imagenestodo.com/wp-content/uploads/2014/05/star_wars_logo.jpg"]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:apiRequest delegate:self];
    [connection start];
}

-(void)rememberPass:(NSString*)userEmail{
    [self getImageTest];
    //self.presupuesto.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"presupuesto")] ] ;
}

-(void)logout{
    token = @"";
    Connection* conn = [[Connection alloc] init];
    [conn openDB];
    [conn deleteSession];
}

-(void)signUpUser:(User*)user{
    NSDictionary *userDic = @{
                              //@"key":@"value"
                              @"email":user.email,
                              @"name":user.name,
                              @"password":user.passwordHash,
                              @"phoneNumber":user.phoneNumber
                              };
    [self performPost:@"Account" :token :userDic :@"Creado correctamente" :@"Ocurrio un error al crear"];
}


-(void)getProducts:(NSString*)filters{
    [self performGet:[NSString stringWithFormat:@"productservices?ignoredpsvalidation=true%@",filters] :token :true];
}

-(void)getProductDetail:(int)idProduct{
    [self performGet:[NSString stringWithFormat:@"productservices/%d",idProduct] :token :false];
}

-(void)getFavorites{
    [self performGet:@"Account" :token :false];
}

-(void)getCities{
    [self performGet:@"Cities" :token :true];
}


-(void)getSelfUser{
    //NSLog(@"retriving self user with token %@",token);
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
                          [self.delegate returnList:responseObject];
                      }else{
                          [self.delegate returnObt:responseObject];
                      }
                      //[self.delegate loaded:true :@"" :[tokBase64 base64EncodedStringWithOptions:0]];
                      //[conn createSession:[tokBase64 base64EncodedStringWithOptions:0]];
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error: %@", [error description]);
                      //[self.delegate loaded:false :@"Revise sus datos" :@""];
                  }
     ];
}


-(void) performPost:(NSString*)url :(NSString*)token :(NSDictionary*)data :(NSString*)successMsg :(NSString*)failMsg {
    NSLog(@"Performing Post");
    NSError *e;
   // NSDictionary *JSON =
   // [NSJSONSerialization JSONObjectWithData: [data dataUsingEncoding:NSUTF8StringEncoding]
     //                               options: NSJSONReadingMutableContainers
       //                               error: &e];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    [operationManager POST:[NSString stringWithFormat:@"%@%@",URLAPI,url] parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", responseObject);
            [self.delegate returnResponse:successMsg];
        }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"Error: %@", [error description]);
                       [self.delegate returnResponse:failMsg];
                       //[self.delegate loaded:false :@"Revise sus datos" :@""];
       }];
}


-(void) performPut:(NSString*)url :(NSString*)token :(NSString*)data :(NSString*)successMsg :(NSString*)failMsg {
    NSLog(@"Performing Put");
    NSError *e;
    NSDictionary *JSON =
    [NSJSONSerialization JSONObjectWithData: [data dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:token forHTTPHeaderField:@"x-Authentication"];
    
    
    [operationManager POST:[NSString stringWithFormat:@"%@&page=0&rows=20&%@",URLAPI,url] parameters:JSON success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        [self.delegate returnResponse:successMsg];
    }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"Error: %@", [error description]);
                       [self.delegate returnResponse:failMsg];
                       //[self.delegate loaded:false :@"Revise sus datos" :@""];
                   }];
    
}



@end
