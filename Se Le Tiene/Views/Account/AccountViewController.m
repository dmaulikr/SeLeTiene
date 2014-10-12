//
//  AccountViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/11/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "AccountViewController.h"
#import "EditAccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController
@synthesize btnFavorites,btnLastOpened,btnLogout,lblCellPhoneUser,lblEmail,lblNameUser,lblPhoneUser,contactView;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    self.title = @"Mi Cuenta";
    contactView.layer.cornerRadius = 5.0f;
    btnLogout.layer.cornerRadius = 5.0f;
    
    btnFavorites.layer.borderWidth = 1.0f;
    btnLastOpened.layer.borderWidth = 1.0f;
    btnFavorites.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnLastOpened.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    int xVal = btnFavorites.bounds.size.width  - 10;
    int yVal = btnFavorites.bounds.size.height - 20;
    
    UIImage *image = [UIImage imageNamed:@"btnArr"];
    UIImageView *imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(xVal-13, yVal/2, 13, 20)];
    [imgArr setImage:image];
    [btnFavorites addSubview:imgArr];
    image = [UIImage imageNamed:@"btnArr"];
    imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(xVal-13, yVal/2, 13, 20)];
    [imgArr setImage:image];
    [btnLastOpened addSubview:imgArr];
    
    
    image = [UIImage imageNamed:@"btnFav"];
    imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(25, 6, 25, 39)];
    [imgArr setImage:image];
    [btnFavorites addSubview:imgArr];
    
    image = [UIImage imageNamed:@"btnHis"];
    imgArr = [[UIImageView alloc] initWithFrame:CGRectMake(25, 13, 26, 26)];
    [imgArr setImage:image];
    [btnLastOpened addSubview:imgArr];
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:UIBarButtonItemStylePlain target:self action:@selector(editUser:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
}

-(IBAction)editUser:(id)sender{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
