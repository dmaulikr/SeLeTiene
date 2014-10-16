//
//  ProductsContViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsContViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    double wCell;
    double hCell;
    int    numColumns;
    double padCell;
    int    wScreen;
    int    hScreen;
}
extern NSMutableArray *productsArray;
@property (weak, nonatomic) IBOutlet UICollectionView *Products;

@end
