//
//  Provider.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/19/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Provider : NSObject

/*
 Proveedor =         {
     cedula = 9876543210;
     ceular = 3144577085;
     cuidad = Tunja;
     email = "david.barinas.dev@gmail.com";
     estado = Activo;
     "fecha_registro" = "/Date(1391040000000+0000)/";
     nombre = "David barinas";
     telefono = "+570386444505";
 };
 
 */

@property (nonatomic, retain) NSString *idProvider;
@property (nonatomic, retain) NSString *celProvider;
@property (nonatomic, retain) NSString *cityProvider;
@property (nonatomic, retain) NSString *emailProvider;
@property (nonatomic, retain) NSString *nameProvider;
@property (nonatomic, retain) NSString *phoneProvider;


@end
