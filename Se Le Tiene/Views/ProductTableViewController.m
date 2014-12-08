//
//  ProductTableViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "ProductTableViewController.h"
#import "ProductDetailViewController.h"
#import "ProductsTableViewCell.h"
#import "Product.h"
#import "Connection.h"

@interface ProductTableViewController ()

@end

@implementation ProductTableViewController
@synthesize table,mode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    APIManagerClass = [[APIManager alloc] init];
    APIManagerClass.delegate = self;
    alert = [[JOAlert alloc]initWithAnimFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-150)];
    
    conn = [[Connection alloc]init];
    [conn openDB];
    
    recList = [conn getRecent];
    
    switch (self.mode) {
        case 0:
            self.tableView.backgroundColor = [UIColor clearColor];
        break;
        case 2:
            NSLog(@"Entro a Favoritos");
            self.title = @"Favoritos";
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
            alert = [[JOAlert alloc]initWithAnimFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
            [APIManagerClass getFavorites];
            [self.view addSubview:alert];
            [alert showAlertAnim];
            mode = 2;
        break;
        case 3:
            self.title = @"Recientes";
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
            mode = 3;
        break;
        default:
            APIManagerClass = [[APIManager alloc] init];
            APIManagerClass.delegate = self;
            [APIManagerClass getProducts:[NSString stringWithFormat:@"%@&%@",orderStr,filterStr]];
            alert = [[JOAlert alloc]initWithAnimFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-150)];
            [self.view addSubview:alert];
            [alert showAlertAnim];
            filter = @"";
            order = @"";
            self.tableView.backgroundColor = [UIColor clearColor];
        break;
    }
    filter = @"";
    order = @"";
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (mode==0) {
        if (![filter isEqualToString:filterStr] || ![order isEqualToString:orderStr]) {
            [self.view addSubview:alert];
            [alert showAlertAnim];
            [APIManagerClass getProducts:[NSString stringWithFormat:@"?%@&%@",orderStr,filterStr]];
            filter = filterStr;
            order = orderStr;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.mode) {
        case 0:
            return [productsArray count];
            
            break;
        case 2:
            return [favList count];
            break;
        case 3:
            return [recList count];
            break;
    }
    return [productsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    Product *prdTemp;
    
    switch (self.mode) {
        case 0:
            prdTemp = (Product*)[productsArray objectAtIndex:indexPath.row];
            break;
        case 2:
            prdTemp = (Product*)[favList objectAtIndex:indexPath.row];
            break;
        case 3:
            prdTemp = (Product*)[recList objectAtIndex:indexPath.row];
            break;
    }
    
    
    cell.imgProduct.layer.cornerRadius = 4;
    cell.imgProduct.layer.masksToBounds = YES;
    
    [cell.strs setStarsNum:[prdTemp getScore]];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.imgProduct.layer.cornerRadius = 3;
    
    if (!prdTemp.imageProduct) {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [prdTemp getImageURL]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (self.mode) {
                    case 0:
                        [((Product*)[productsArray objectAtIndex:indexPath.row]) setImageProduct:[UIImage imageWithData: data]];
                        break;
                    case 2:
                        [((Product*)[favList objectAtIndex:indexPath.row]) setImageProduct:[UIImage imageWithData: data]];
                        break;
                    case 3:
                        [((Product*)[recList objectAtIndex:indexPath.row]) setImageProduct:[UIImage imageWithData: data]];
                        break;
                }
                
                cell.imgProduct.image = [UIImage imageWithData: data];
            });
        });
    }else{
        cell.imgProduct.image = prdTemp.imageProduct;
    }
    cell.imgProduct.layer.masksToBounds = YES;
    cell.lblNameProduct.text = prdTemp.nameProduct;
    cell.lblNameUser.text = prdTemp.providerProduct.nameProvider;
    cell.lblDescProduct.text = prdTemp.descProduct;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *tmpView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    switch (self.mode) {
        case 0:
            tmpView.actProduct = [productsArray objectAtIndex:indexPath.row];
            break;
        case 2:
            tmpView.actProduct = [favList objectAtIndex:indexPath.row];
            break;
        case 3:
            tmpView.actProduct = [recList objectAtIndex:indexPath.row];
            break;
    }
    
    [self.navigationController pushViewController:tmpView animated:YES];
}

-(void) returnObt:(id)responseObject{
    NSLog(@"Retorno un objeto");
    NSDictionary *test = (NSDictionary*)responseObject;
    NSMutableArray *tmpArray = (NSMutableArray*)test[@"favorites"];
    for (id key in (NSDictionary*)responseObject) {
        Product *tmpProduct = [[Product alloc] init];
        tmpProduct.nameProduct = key[@"nombre"];
        tmpProduct.scoreProduct = key[@"calificacion"];
        tmpProduct.descProduct = key[@"descripcion"];
        NSDictionary *prov = key[@"Proveedor"];
        tmpProduct.providerProduct.nameProvider  = prov[@"nombre"];
        tmpProduct.providerProduct.emailProvider = prov[@"email"];
        tmpProduct.providerProduct.phoneProvider = prov[@"telefono"];
        tmpProduct.providerProduct.celProvider   = prov[@"ceular"];
        [tmpArray addObject:tmpProduct];
    }
    [(UITableView*)self.view reloadData];
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
        tmpProduct.providerProduct.nameProvider  = [[NSString stringWithFormat:@"%@",key[@"ownerName"]] isEqualToString:@"<null>"]? @"No especificado!":key[@"ownerName"];
        [tmpArray addObject:tmpProduct];
    }
    NSLog(@"Modo!!! %d", self.mode);
    switch (self.mode) {
        case 0:
            productsArray = tmpArray;
        break;
        case 2:
            favList = tmpArray;
        break;
    }
    [(UITableView*)self.view reloadData];
    [alert dismissAlertAnim];
}

@end
