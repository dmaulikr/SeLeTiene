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


//#import "<#header#>"

@implementation APIManager

-(id)init{
    self = [super init];
    if (self) {
      // URLAPI = @"http://api.seletiene.olinguito.com.co/SeLeTiene.svc/";
        URLAPI = @"http://se-le-tiene.cloudapp.net/SeLeTiene.svc/";
    }
    return self;
}

-(void)loginEmail:(NSString*)userEmail :(NSString*)userPass{
    Connection* conn = [[Connection alloc] init];
    [conn openDB];
    NSData *tokBase64 = [[NSString stringWithFormat:@"%@:%@", userEmail, userPass] dataUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [operationManager.requestSerializer setValue:[tokBase64 base64EncodedStringWithOptions:0] forHTTPHeaderField:@"x-Authentication"];
    [operationManager GET:[NSString stringWithFormat:@"%@usuario/me",URLAPI] parameters:nil
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSLog(@"Success: %@", responseObject);
                      [self.delegate loaded:true :@"" :[tokBase64 base64EncodedStringWithOptions:0]];
                      [conn createSession:[tokBase64 base64EncodedStringWithOptions:0]];
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      //NSLog(@"Error: %@", [error description]);
                      NSLog(@"Error: %@", [error localizedDescription]);

                      
                      if ([[error localizedDescription] rangeOfString:@"(401)"].location != NSNotFound) {
                          //NSLog(@"NO autorizado");
                          [self.delegate loaded:false :@"Revise sus datos" :@""];
                      } else {
                          //NSLog(@"Error de servidor");
                          [self.delegate loaded:false :@"Error en el servidor" :@""];
                      }
                      
                  }
     ];
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
    [self performPost:@"usuario" :token :[user JSONString] :@"Creado correctamente" :@"Ocurrio un error al crear"];
}


-(void)getProducts{
    [self performGet:@"producto?orderby=p(a-z)&page=0&rows=20" :token :true];
    
    /*NSMutableArray *tst = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        Product *tmp = [[Product alloc] init];
        [tmp setNamProduct:[NSString stringWithFormat:@"Envueltos %d",i]];
        [tmp setDescProduct:@"Lorem Ipsum dolor amet"];
        [tmp setImageURL:[NSURL URLWithString:@"http://lorempixel.com/g/190/80/"]];
        [tst addObject:tmp];
    }
    return tst;*/
}

-(void)getProductDetail:(int)idProduct{
    
}

-(void)getSelfUser{
    
    [self performGet:@"usuario/me" :token :false];
}


#pragma CONNECTION DELEGATE


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    total = response.expectedContentLength;
    NSLog(@"Expected %lld",response.expectedContentLength);
     //NSLog(@"Tamaño de la descarga: %@", response);
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
    NSLog(@"Performing Get");
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [operationManager.requestSerializer setValue:token forHTTPHeaderField:@"x-Authentication"];
    [operationManager GET:[NSString stringWithFormat:@"%@%@",URLAPI,url] parameters:nil
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSLog(@"Success: %@", responseObject);
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


-(void) performPost:(NSString*)url :(NSString*)token :(NSString*)data :(NSString*)successMsg :(NSString*)failMsg {
    NSLog(@"Performing Post");
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
    
    
    [operationManager POST:[NSString stringWithFormat:@"%@%@",URLAPI,url] parameters:JSON success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
