//
//  ProductsViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/1/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "NVControllerGeneric.h"
#import "ProductsViewController.h"
#import "ProductTableViewController.h"
#import "Filter/FilterViewController.h"
#import "Offer/OfferViewController.h"
#import "AccountViewController.h"


@interface ProductsViewController ()

@end

@implementation ProductsViewController
@synthesize GridView,ListView,typeView,searchBar,btnFilter,btnOpenPopUP,loader,viewMenu,imgTmp,download,APIManagerClass;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    if ([@"" isEqualToString:token]) {
        NVControllerGeneric *tmp = (NVControllerGeneric*)[self.storyboard instantiateViewControllerWithIdentifier:@"NVLogin"];
        tmp.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:tmp animated:YES completion:nil];
        
    }else{
        APIManagerClass = [[APIManager alloc]init];
        APIManagerClass.delegate = self;
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoHeader"]];
        
        imgTmp = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height - 220)];
        imgTmp.backgroundColor = [UIColor clearColor];
        
        viewMenu.delegate = self;
        [viewMenu setButton:1];
        
        GridView.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        GridView.view.frame = CGRectMake(0, 0, self.viewLoaded.bounds.size.width,self.viewLoaded.bounds.size.height);
        GridView = [self.storyboard instantiateViewControllerWithIdentifier:@"GridView"];
        
        ListView.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        ListView.view.frame = CGRectMake(0, 0, self.viewLoaded.bounds.size.width,self.viewLoaded.bounds.size.height);
        ListView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListView"];
        
        searchBar.backgroundColor = [UIColor colorWithRed:0.243 green:0.592 blue:0.812 alpha:1];
        [searchBar setBackgroundColor:[UIColor colorWithRed:0.243 green:0.592 blue:0.812 alpha:1]];
        [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"bgSearch.png"] forState:UIControlStateNormal];

        searchBar.delegate = self;
        UITextField *searchField = [searchBar valueForKey:@"_searchField"];
        searchField.textColor = [UIColor whiteColor];
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        searchField.tintColor = [UIColor whiteColor];
        searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        searchField.keyboardAppearance = UIKeyboardAppearanceDark;
        
        UIImage *image = [UIImage imageNamed: @"btnSearch.png"];
        UIImageView *iView = [[UIImageView alloc] initWithImage:image];
        searchField.leftView = iView;
        
        btnFilter.layer.borderColor = [UIColor colorWithRed:0.243 green:0.592 blue:0.812 alpha:1].CGColor;
        btnFilter.layer.borderWidth = 1.0f;
        btnFilter.layer.cornerRadius = 5.0f;
        btnOpenPopUP.layer.borderColor = [UIColor colorWithRed:0.243 green:0.592 blue:0.812 alpha:1].CGColor;
        btnOpenPopUP.layer.borderWidth = 1.0f;
        btnOpenPopUP.layer.cornerRadius = 5.0f;
        
        transition = [CATransition animation];
        transition.duration = 0.5f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    /*download = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    download.alpha = 0.5;
    download.frame = CGRectMake(0, 0, self.view.bounds.size.width, 20);
    download.backgroundColor = [UIColor redColor];
    download.layer.backgroundColor = [UIColor orangeColor].CGColor;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    download.transform = transform;
    download.progress = 0.0;
    [self.view addSubview:download];*/
}

#pragma SEARCH BAR METHODS DELEGATE

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Buscando: %@", self.searchBar.text);
    filterStr = [NSString stringWithFormat:@"?q=%@",self.searchBar.text];
    [APIManagerClass getProducts:@""];
    [self.searchBar resignFirstResponder];
    [imgTmp removeFromSuperview];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.view addSubview:imgTmp];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [imgTmp removeFromSuperview];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [imgTmp removeFromSuperview];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [searchBar resignFirstResponder];
    [imgTmp removeFromSuperview];
}


#pragma CUSTOM METHODS

- (IBAction)changeView:(id)sender {
    [self.containerViewController swapViewControllers];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}
- (IBAction)filterSearch:(id)sender {
    FilterViewController *fVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterView"];
    [self.navigationController pushViewController:fVC animated:YES];
}

- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect clippedRect  = CGRectMake(0 ,158,img.size.width, self.view.bounds.size.height - 160);
    CGImageRef imageRef = CGImageCreateWithImageInRect(img.CGImage, clippedRect);
    return [UIImage imageWithCGImage:imageRef];
}

#pragma MENU DELEGATE

- (void) fiendView{
    NSLog(@"Uno");
}
- (void) addView{
    OfferViewController *oVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OfferView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:oVC animated:NO];
}
- (void) profileView{
    AccountViewController *aVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountView"];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:aVC animated:NO];
}


#pragma API DELEGATE

- (void) percentageDownloaded:(double)dataDownloaded{
    download.progress = dataDownloaded;
    if (download.progress == 1.0) {
        download.tintColor = [UIColor colorWithRed:0.490 green:0.773 blue:0.482 alpha:1];
        [download removeFromSuperview];
    }
}

-(void) loadedImage:(UIImage *)imageLoaded{
    //self.imgProduct.image = imageLoaded;
}

@end
