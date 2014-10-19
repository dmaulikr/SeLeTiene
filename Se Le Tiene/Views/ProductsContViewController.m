//
//  ProductsContViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "ProductsContViewController.h"
#import "ProductCollectionViewCell.h"
#import "ProductsViewController.h"
#import "Product.h"

#import "ProductDetailViewController.h"

#import "APIManager.h"
@interface ProductsContViewController ()
@end

@implementation ProductsContViewController
@synthesize Products;


#pragma mark UIViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    Products.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0];
    
    wScreen = self.view.bounds.size.width;
    wCell = (wScreen*0.88)/2;
    
    if (wCell>300) {
        wCell = (wScreen*0.88)/3;
    }
    hCell = wCell/1.39;
    padCell = wScreen*0.03;
    
    APIManagerClass = [[APIManager alloc] init];
    APIManagerClass.delegate = self;
    
    [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(reloaded:) userInfo:nil repeats:NO];
}


-(IBAction)reloaded:(id)sender{
    NSLog(@"Relodeando");
    [self.Products reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [APIManagerClass getProducts];
}

- (NSInteger)numberOfSections{
    return 1;
}
- (NSInteger)numberOfItemsInSection:(NSInteger)section{
    return [productsArray count];
}
-(int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [productsArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"productCell" forIndexPath:indexPath];
    Product *prdTemp = (Product*)[productsArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 5;
    cell.layer.borderColor = [UIColor colorWithRed:0.788 green:0.788 blue:0.788 alpha:1].CGColor;
    cell.layer.borderWidth = 1.5f;
    cell.imgProduct.layer.cornerRadius = 3;
    [cell.strs setStarsNum:[prdTemp getScore]];
    
    if (!prdTemp.imageProduct) {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [prdTemp getImageURL]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                [((Product*)[productsArray objectAtIndex:indexPath.row]) setImageProduct:[UIImage imageWithData: data]];
                cell.imgProduct.image = [UIImage imageWithData: data];
            });
        });
    }else{
        cell.imgProduct.image = prdTemp.imageProduct;
    }
    cell.imgProduct.layer.masksToBounds = YES;
    cell.lblNameProduct.text = prdTemp.nameProduct;
    cell.lblNameUser.text = prdTemp.providerProduct.nameProvider;
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(wCell,hCell);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   NSLog(@"Entra al segue para ir al detalle");
   
}

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

-(void) returnList:(id)responseObject
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    NSLog(@"Retorno una lista");
    for (id key in (NSDictionary*)responseObject) {
        NSLog(@"Toma tu producto");
        Product *tmpProduct = [[Product alloc] init];
        tmpProduct.nameProduct = key[@"nombre"];
        tmpProduct.scoreProduct = key[@"calificacion"];
        tmpProduct.descProduct = key[@"descripcion"];
        NSLog(@"%@", key);
        NSLog(@"Valor buscado %@", key[@"Proveedor"]);
        NSDictionary *prov = key[@"Proveedor"];
        tmpProduct.providerProduct.nameProvider  = prov[@"nombre"];
        tmpProduct.providerProduct.emailProvider = prov[@"email"];
        tmpProduct.providerProduct.phoneProvider = prov[@"telefono"];
        tmpProduct.providerProduct.celProvider   = prov[@"ceular"];
        [tmpArray addObject:tmpProduct];
    }
    productsArray = tmpArray;
    [self.Products reloadData];
}

@end
