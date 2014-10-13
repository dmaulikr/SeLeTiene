//
//  ProductDetailViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/5/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import "APIManager.h"
#import "MenuView.h"

@interface ProductDetailViewController : UIViewController <APIManagerDelegate,MenuViewDelegate>{
    int x;
    int z;
    int s;
    CATransition *transition;
}
@property (strong,nonatomic) UIProgressView* download;
@property (strong,nonatomic) UIView *tstBtn;
@property (weak,nonatomic) IBOutlet UIImageView * imgProduct;
@property (weak,nonatomic) IBOutlet UILabel     * lblTitleProduct;
@property (weak,nonatomic) IBOutlet UILabel     * lblUserProduct;
@property (weak,nonatomic) IBOutlet UILabel     * DescProduct;
@property (weak,nonatomic) IBOutlet UIButton    * btnContact;

@property (strong,nonatomic) UIButton *favBtn;

@property (weak,nonatomic)   IBOutlet MenuView  *viewMenu;

@property (strong,nonatomic) UIButton *lblPhone;
@property (strong,nonatomic) UIButton *lblCell;
@property (strong,nonatomic) UIButton *btnTw;
@property (strong,nonatomic) UIButton *btnFb;

@end
