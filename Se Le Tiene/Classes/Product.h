//
//  Product.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/10/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Provider.h"

@interface Product : NSObject

/* JSON Example
 
 {
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
     calificacion = "4.3";
     "cedula_proveedor" = 9876543210;
     descripcion = "Las mejores arepas";
     "fecha_registro" = "/Date(1391040000000+0000)/";
     id = 1;
     nombre = Arepas;
 }
 
 */

@property (nonatomic, retain) NSString *idProduct;
@property (nonatomic, retain) Provider *providerProduct;
@property (nonatomic, retain) NSString *descProduct;
@property (nonatomic, retain) NSString *nameProduct;
@property (nonatomic, retain) UIImage *imageProduct;
@property (nonatomic, retain) NSString *scoreProduct;

-(NSURL*) getImageURL;
-(int) getScore;

@end
