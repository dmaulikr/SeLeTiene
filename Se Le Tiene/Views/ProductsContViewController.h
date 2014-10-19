//
//  ProductsContViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

@interface ProductsContViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, APIManagerDelegate>{
    double wCell;
    double hCell;
    int    numColumns;
    double padCell;
    int    wScreen;
    int    hScreen;
    APIManager *APIManagerClass;
}
extern NSMutableArray *productsArray;
@property (weak, nonatomic) IBOutlet UICollectionView *Products;

@end
