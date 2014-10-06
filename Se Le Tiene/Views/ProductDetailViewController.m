//
//  ProductDetailViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/5/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
@synthesize imgProduct,btnContact,lblTitleProduct,lblUserProduct,DescProduct,btnMen1,btnMen2,btnMen3,viewMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    

    [imgProduct.layer setShadowOffset:CGSizeMake(0, 3)];
    [imgProduct.layer setCornerRadius:5];
    [imgProduct.layer setShadowOpacity:0.4];
    [imgProduct.layer setShadowRadius:3.0f];
    [imgProduct.layer setShouldRasterize:YES];
    imgProduct.layer.masksToBounds = YES;
    [imgProduct.layer setCornerRadius:10.0f];
    [imgProduct.layer setShadowPath: [[UIBezierPath bezierPathWithRoundedRect:imgProduct.layer.bounds cornerRadius:12.0f] CGPath]];
    
    DescProduct.textAlignment = NSTextAlignmentJustified;
    
    btnContact.layer.cornerRadius = 10.0f;
    
    self.navigationController.title = @"Ofrecer";
    self.title = @"Ofrecer";
    
    
    btnMen1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnMen1.frame = CGRectMake(0, 0, self.viewMenu.bounds.size.width/3, 60);
    [btnMen1 setImage:[UIImage imageNamed:@"btnSearchMenu"] forState:UIControlStateNormal];
    btnMen1.tintColor = [UIColor colorWithRed:0.263 green:0.596 blue:0.804 alpha:1];
    [viewMenu addSubview:btnMen1];
    
    
    btnMen2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnMen2.frame = CGRectMake(self.viewMenu.bounds.size.width/3, 0, self.viewMenu.bounds.size.width/3, 60);
    [btnMen2 setImage:[UIImage imageNamed:@"btnAddMenu"] forState:UIControlStateNormal];
    btnMen2.tintColor = [UIColor whiteColor];
    [viewMenu addSubview:btnMen2];
    
    btnMen3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnMen3.frame = CGRectMake((self.viewMenu.bounds.size.width/3)*2, 0, self.viewMenu.bounds.size.width/3, 60);
    [btnMen3 setImage:[UIImage imageNamed:@"btnUserMenu"] forState:UIControlStateNormal];
    btnMen3.tintColor = [UIColor whiteColor];
    [viewMenu addSubview:btnMen3];
    
}


@end
