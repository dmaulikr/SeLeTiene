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
@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *telefono;
@property (nonatomic, retain) NSString *password;



@end
