//
//  ProductsContViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "ProductsContViewController.h"
#import "ProductCollectionViewCell.h"

@interface ProductsContViewController ()

@end

@implementation ProductsContViewController
@synthesize Products;

- (void)viewDidLoad {
    [super viewDidLoad];
    Products.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Grid View Appearing");
}

- (NSInteger)numberOfSections{
    return 1;
}
- (NSInteger)numberOfItemsInSection:(NSInteger)section{
    return 1;
}
-(int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductCollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"productCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 5;
    cell.layer.borderColor = [UIColor colorWithRed:0.788 green:0.788 blue:0.788 alpha:1].CGColor;
    cell.layer.borderWidth = 1.0f;
    /*cell.colBtn.backgroundColor = [UIColor colorWithRed:0.867 green:0.737 blue:0.255 alpha:1];
    cell.colBtn.layer.borderColor = [UIColor colorWithRed:0.992 green:0.451 blue:0.196 alpha:1].CGColor;
    cell.colBtn.layer.borderWidth = 5;
    cell.colBtn.layer.cornerRadius = 5;
    CGRect newFrame = cell.colBtn.frame;
    newFrame.origin.y += 150; // add 100 to y's current value
    newFrame.size.width = 40;
    cell.colBtn.frame = newFrame;*/
    
   /* cell.colBtn = [[btnColor alloc] initWithFrame:CGRectMake(-5, -5, cell.frame.size.width+10, cell.frame.size.width+5)];
    cell.colBtn.backgroundColor = [UIColor colorWithRed:0.980 green:0.188 blue:0.192 alpha:1];
    cell.colBtn.layer.borderColor = [UIColor colorWithRed:0.196 green:0.196 blue:0.196 alpha:1].CGColor;
    cell.colBtn.layer.cornerRadius = 10;
    cell.colBtn.layer.borderWidth = 5;
    cell.colBtn.layer.masksToBounds = YES;
    [cell.colBtn addTarget:self action:@selector(test:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [cell addSubview:cell.colBtn];
    cell.colBtn.tag = ((int)indexPath.row)+1;
    NSString* col = [[gameController getGameMatrix] objectInSection:c :r];
    cell.colBtn.color = col;
    [cell.colBtn setBlockColor: col];
    if(r==(cuadros-1)){
        c++;
        r = 0;
    }else
        r++;*/
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

/*- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return sep;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return sep;
}*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(141, 101);
}



@end
