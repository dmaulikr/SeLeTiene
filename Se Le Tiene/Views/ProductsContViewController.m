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
    
    APIManager *tst = [[APIManager alloc] init];
    productsArray = [tst getProducts];
    
    [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(reloaded:) userInfo:nil repeats:NO];
}

-(IBAction)reloaded:(id)sender{
    NSLog(@"Relodeando");
    [self.Products reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Grid View Appearing");
    [super viewDidAppear:animated];
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
    
    if (![prdTemp getImageProduct]) {
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
        cell.imgProduct.image = [prdTemp getImageProduct];
    }
    
    cell.imgProduct.layer.masksToBounds = YES;
    cell.lblNameProduct.text = prdTemp.getNamProduct;
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

/*- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}*/



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(141, 101);
    return CGSizeMake(wCell,hCell);
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   NSLog(@"Entra al segue para ir al detalle");
   
}



@end
