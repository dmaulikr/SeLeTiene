//
//  User.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectMap.h"

@interface User : NSObject

/*"email":"String content",
"id":2147483647,
"nombre":"String content",
"telefono":"String content"*/

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *mobileNumber;
@property (nonatomic, retain) NSString *passwordHash;
@property (nonatomic, retain) NSString *cityID;
@property (nonatomic, retain) NSString *cityName;
@property (nonatomic, retain) NSString *deptoID;
@property (nonatomic, retain) NSString *deptoName;



@end
