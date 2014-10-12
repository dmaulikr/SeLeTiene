//
//  APIManager.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "APIManager.h"
#import "Product.h"
//#define APIip @"http://api.bogotacomovamos.org/api/datas/71/?key=comovamos/"
#define APIip @"https://api.github.com/users/lojals/repos"


@implementation APIManager

-(id)init{
    self = [super init];
    if (self) {
       respo = @"";
    }
    return self;
}


-(BOOL)loginEmail:(NSString*)userEmail :(NSString*)userPass{
    // Setup NSURLConnection
    /*NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:30.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    [connection release];
    
    // NSURLConnection Delegates
    - (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
        if ([challenge previousFailureCount] == 0) {
            NSLog(@"received authentication challenge");
            NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"USER"
                                                                        password:@"PASSWORD"
                                                                     persistence:NSURLCredentialPersistenceForSession];
            NSLog(@"credential created");
            [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
            NSLog(@"responded to authentication challenge");
        }
        else {
            NSLog(@"previous authentication failure");
        }
    }
    
    - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
        ...
    }
    
    - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
        ...
    }
    
    - (void)connectionDidFinishLoading:(NSURLConnection *)connection {
        ...
    }
    
    - (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
        ...
    }
    
    */
    return YES;
}

-(UIImage*) getImageTest{
    UIImage * test;
    NSURLRequest *apiRequest    = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.karmapanda.com/wp-content/uploads/2008/12/gato-envuelto.jpg"]];
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
     NSLog(@"Se atreve a entrar por aca?");
    NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"USERNAME"
                                                                password:@"PASSWORD"
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
   //  NSLog(@"Se atreve a entrar por aca?");
    if ([[NSString stringWithFormat:@"%@",connection.currentRequest.URL] isEqualToString:@"http://www.karmapanda.com/wp-content/uploads/2008/12/gato-envuelto.jpg"]) {
        [self.delegate loadedImage:[UIImage imageWithData:apiData]];
    }else{
        NSDictionary *apiResponse = [NSJSONSerialization JSONObjectWithData:apiData options:kNilOptions error:nil];
    }
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

@end
