//
//  OfferSerViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "OfferSerViewController.h"

@interface OfferSerViewController ()

@end

@implementation OfferSerViewController
@synthesize txtCapac,txtComment,btnType;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    txtComment.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtComment.layer.borderWidth = 1.0f;
    
    txtCapac.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtCapac.layer.borderWidth = 1.0f;
    
    btnType.layer.borderWidth = 1.0f;
    btnType.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    int xVal = btnType.bounds.size.width  - 10;
    int yVal = btnType.bounds.size.height - 20;
    
    UIImage *image = [UIImage imageNamed:@"btnArr"];
    UIImageView *imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(xVal-13, yVal/2, 13, 20)];
    [imgArr setImage:image];
    [btnType addSubview:imgArr];
    
    txtComment.contentInset = UIEdgeInsetsMake(30,0,0,0);
    
    txtCapac.contentInset = UIEdgeInsetsMake(30,0,0,0);
}

@end
