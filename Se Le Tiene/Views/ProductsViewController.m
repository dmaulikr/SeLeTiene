//
//  ProductsViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductTableViewController.h"


@interface ProductsViewController ()

@end

@implementation ProductsViewController
@synthesize GridView,ListView,typeView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    GridView = [self.storyboard instantiateViewControllerWithIdentifier:@"GridView"];
    ListView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListView"];
    
    [self changeView:typeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// CUSTOM METHODS

- (IBAction)changeView:(id)sender {
    [[self.viewLoaded subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UISegmentedControl * tmpControl = sender;
    NSLog(@"Selected %ld", (long)tmpControl.selectedSegmentIndex);
    if (tmpControl.selectedSegmentIndex == 0) {
        [self.viewLoaded addSubview:GridView.view];
    }
    else{
        [self.viewLoaded addSubview:ListView.view];
    }
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
