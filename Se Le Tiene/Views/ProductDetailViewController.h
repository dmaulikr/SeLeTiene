//
//  ProductDetailViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/5/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

@interface ProductDetailViewController : UIViewController{
    int x;
    int z;
    int s;
}

@property (strong,nonatomic) UIView *tstBtn;
@property (weak,nonatomic) IBOutlet UIImageView * imgProduct;
@property (weak,nonatomic) IBOutlet UILabel     * lblTitleProduct;
@property (weak,nonatomic) IBOutlet UILabel     * lblUserProduct;
@property (weak,nonatomic) IBOutlet UILabel     * DescProduct;
@property (weak,nonatomic) IBOutlet UIButton    * btnContact;

@property (weak,nonatomic)   IBOutlet UIView      *viewMenu;
@property (strong,nonatomic) IBOutlet UIButton    *btnMen1;
@property (strong,nonatomic) IBOutlet UIButton    *btnMen2;
@property (strong,nonatomic) IBOutlet UIButton    *btnMen3;

@property (strong,nonatomic) UIButton *lblPhone;
@property (strong,nonatomic) UIButton *lblCell;
@property (strong,nonatomic) UIButton *btnTw;
@property (strong,nonatomic) UIButton *btnFb;

@end
