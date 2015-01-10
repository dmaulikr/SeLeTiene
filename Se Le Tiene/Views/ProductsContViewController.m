//
//  ProductsContViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductsContViewController.h"
#import "ProductCollectionViewCell.h"
#import "ProductsViewController.h"
#import "APIManager.h"
#import "Product.h"

@interface ProductsContViewController ()
@end

@implementation ProductsContViewController
@synthesize Products,alert,refresh;


#pragma mark UIViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    Products.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0];
    wScreen = self.view.bounds.size.width;
    wCell = (wScreen*0.88)/2;
    if (wCell>300)
        wCell = (wScreen*0.88)/3;
    hCell = wCell/1.39;
    padCell = wScreen*0.03;
    APIManagerClass = [[APIManager alloc] init];
    APIManagerClass.delegate = self;
    [APIManagerClass getProducts:[NSString stringWithFormat:@"%@&%@",orderStr,filterStr]];
    
    alert = [[JOAlert alloc]initWithAnimFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-150)];
    [self.view addSubview:alert];
    [alert showAlertAnim];
    filter = @"";
    order = @"";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFilter:) name:@"filterStrChange" object:nil];
    
    refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Recargando"];
    [refresh addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    [self.Products addSubview:refresh];
}

- (void) refershControlAction{
    [APIManagerClass getProducts:[NSString stringWithFormat:@"&%@&%@",orderStr,filterStr]];
}


- (void)changeFilter:(NSNotification*)notification{
    [self.view addSubview:alert];
    [alert showAlertAnim];
    [APIManagerClass getProducts:[NSString stringWithFormat:@"&%@&%@",orderStr,filterStr]];
    filter = filterStr;
    order = orderStr;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (![filter isEqualToString:filterStr] || ![order isEqualToString:orderStr]) {
        [self.view addSubview:alert];
        [alert showAlertAnim];
        [APIManagerClass getProducts:[NSString stringWithFormat:@"%@&%@",orderStr,filterStr]];
        filter = filterStr;
        order = orderStr;
    }
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [APIManagerClass getFavorites];
        });
    });
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *tmpView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    tmpView.actProduct = [productsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:tmpView animated:YES];
}

-(void) returnList:(id)responseObject :(NSString*)url
{
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (id key in (NSDictionary*)responseObject) {
        Product *tmpProduct = [[Product alloc] init];
        tmpProduct.idProduct = key[@"id"];
        tmpProduct.nameProduct = key[@"title"];
        tmpProduct.scoreProduct = key[@"rating"];
        tmpProduct.descProduct = key[@"description"];
        tmpProduct.urlImage = key[@"imageFile"];
        tmpProduct.providerProduct.nameProvider  = [[NSString stringWithFormat:@"%@",key[@"ownerName"]] isEqualToString:@"<null>"]? @"No especificado!":key[@"ownerName"];
        [tmpArray addObject:tmpProduct];
    }
    if ([url isEqualToString:@"Account/Favorites"]) {
        favArray = tmpArray;
    }else{
        productsArray = tmpArray;
        [self.Products reloadData];
        [alert dismissAlertAnim];
    }
    [refresh endRefreshing];
}

@end
