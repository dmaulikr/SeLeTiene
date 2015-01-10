//
//  ProductsContViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"
#import "Product.h"
#import "JOAlert.h"

@interface ProductsContViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, APIManagerDelegate>{
    double wCell;
    double hCell;
    int    numColumns;
    double padCell;
    int    wScreen;
    int    hScreen;
    APIManager *APIManagerClass;
    NSString* filter;
    NSString* order;
}
extern NSMutableArray *favArray;
extern NSMutableArray *productsArray;
extern NSString *orderStr;
extern NSString *filterStr;

@property (weak, nonatomic) IBOutlet UICollectionView *Products;
@property (strong, nonatomic) JOAlert *alert;
@property (strong, nonatomic) UIRefreshControl *refresh;


@end
