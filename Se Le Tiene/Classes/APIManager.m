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

@implementation APIManager

-(id)init{
    self = [super init];
    if (self) {
       URLAPI = @"http://api.seletiene.olinguito.com.co/SeLeTiene.svc/";
    }
    return self;
}


-(BOOL)loginEmail:(NSString*)userEmail :(NSString*)userPass{
    NSString *URL = [NSString stringWithFormat:@"%@usuario/me",URLAPI];
    NSData *tokBase64 = [[NSString stringWithFormat:@"%@:%@", userEmail, userPass] dataUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [operationManager.requestSerializer setValue:[tokBase64 base64EncodedStringWithOptions:0] forHTTPHeaderField:@"x-Authentication"];

    Connection* conn = [[Connection alloc] init];
    [conn openDB];
    
    [operationManager GET:URL parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Success: %@", responseObject);
              [conn createSession:[tokBase64 base64EncodedStringWithOptions:0]];
              [self.delegate loaded:true :@""];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", [error description]);
              [self.delegate loaded:false :@"Revise sus datos"];
          }
     ];
    return YES;
}

-(UIImage*) getImageTest{
    UIImage * test;
    NSURLRequest *apiRequest    = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://imagenestodo.com/wp-content/uploads/2014/05/star_wars_logo.jpg"]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:apiRequest delegate:self];
    [connection start];
    NSLog(@"Entro aca");
    return test;
}

-(BOOL)rememberPass:(NSString*)userEmail{
    
    
    NSLog(@"Entro aca");
    [self getImageTest];
    
    //resp  = [self makeRestAPICall: APIip];
   // NSDictionary *json = [self makeRestAPICall2:APIip];
   // NSLog(@"Realiza Qyery %@",json);
    //NSLog(@"%@",[json objectForKey:(@"description")]);
    
    //NSLog(@"%@",[json objectForKey:(@"name")]);
    /*self.presupuesto.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"presupuesto")] ] ;
    self.estado.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"estado")] ] ;
    self.adjudicado.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"name")] ] ;
    self.localizacion.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"lugar")] ] ;
    self.name.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"name")] ] ;
    self.adjudicado.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"adjudicado")] ] ;
    
    self.dat1.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"fecha_inicial")] ] ;
    self.dat2.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"fecha_final")] ] ;
    
    self.progress.text = [NSString stringWithFormat:@"%@", [json objectForKey:(@"porcentaje")] ] ;
    
    NSString *str = [NSString stringWithFormat:@"%@", [json objectForKey:(@"porcentaje")] ] ;
    
    self.progressView.progress = (str.floatValue)/100;*/
    
    
    /*NSURLRequest *apiRequest    = [NSURLRequest requestWithURL:[NSURL URLWithString:APIip]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:apiRequest delegate:self];
    [connection start];*/
    //NSLog(@"Entro aca");
    
    return NO;
}

-(void)logout{
    
}

-(NSString*)signUpUser:(User*)user{
    return @"";
}



-(NSMutableArray*)getProducts{
    NSMutableArray *tst = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        Product *tmp = [[Product alloc] init];
        [tmp setNamProduct:[NSString stringWithFormat:@"Envueltos %d",i]];
        [tmp setDescProduct:@"Lorem Ipsum dolor amet"];
        [tmp setImageURL:[NSURL URLWithString:@"http://lorempixel.com/g/190/80/"]];
        [tst addObject:tmp];
    }
    return tst;
}



-(NSDictionary*) makeRestAPICall2 : (NSString*) reqURLStr
{
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString: reqURLStr]];
    NSURLResponse *resp = nil;
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: Request returningResponse: &resp error: &error];
    NSLog(@"%@",resp);
    NSLog(@"%@",response);
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    return json;
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
     NSLog(@"Necesita autenticación");
    NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"pedro@gmail.com"
                                                                password:@"1234"
                                                             persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
}

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
    /*NSLog(@"%@",connection.currentRequest.URL);
    if ([[NSString stringWithFormat:@"%@",connection.currentRequest.URL] isEqualToString:@"http://imagenestodo.com/wp-content/uploads/2014/05/star_wars_logo.jpg"]) {
        [self.delegate loadedImage:[UIImage imageWithData:apiData]];
    }else{
        NSDictionary *apiResponse = [NSJSONSerialization JSONObjectWithData:apiData options:kNilOptions error:nil];
        NSLog(@"%@",apiResponse);
    }*/
    
    
    //NSArray *events = [apiResponse objectForKey:@"owner"];
   // NSLog(@"%@",connection);
    //NSLog(@"WTH %@",apiResponse);
    
    /*for (NSDictionary *event in events) {
        NSLog(@"%@", event);
    }*/
    /*for (NSDictionary *event in events) {
        NSLog(@"%@", [event objectForKey:@"name"]);
        NSDictionary *images      = [event objectForKey:@"images"];
        NSArray *image_collection = [images objectForKey:@"images"];
        for (NSDictionary *image in image_collection) {
            NSLog(@"%@", [image objectForKey:@"id"]);
            NSDictionary *transforms      = [image objectForKey:@"transforms"];
            NSArray *transform_collection = [transforms objectForKey:@"transforms"];
            for (NSDictionary *transform in transform_collection) {
                NSLog(@"%@", [transform objectForKey:@"url"]);
            }
        }
    }*/
}

-(Product*)getProductDetail:(int)idProduct{
    Product *g;
    return g;
}

@end
