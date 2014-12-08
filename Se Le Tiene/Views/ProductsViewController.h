//
//  ProductsViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsContViewController.h"
#import "ContainerViewController.h"
#import "ProductTableViewController.h"
#import "MenuView.h"
#import "APIManager.h"


@interface ProductsViewController : UIViewController <UISearchBarDelegate,MenuViewDelegate,APIManagerDelegate>{
    CATransition *transition;
}

extern NSString *token;
extern NSString *filterStr;

@property (strong,nonatomic) UIProgressView* download;
@property (weak, nonatomic) IBOutlet UIView *viewLoaded;
@property (strong,nonatomic) ProductsContViewController *GridView;
@property (strong,nonatomic) ProductTableViewController *ListView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeView;
@property (weak, nonatomic) IBOutlet UIButton *btnFilter;
@property (weak, nonatomic) IBOutlet UIButton *btnOpenPopUP;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) ContainerViewController *containerViewController;

@property (retain,nonatomic) UIProgressView *loader;
@property (strong,nonatomic) APIManager *APIManagerClass;
@property (weak, nonatomic) IBOutlet MenuView *viewMenu;

@property (strong,nonatomic) UIView *imgTmp;


@end
