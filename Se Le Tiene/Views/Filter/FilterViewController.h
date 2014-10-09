//
//  FilterViewController.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UISegmentedControl *serviceSelector;
@property (weak, nonatomic) IBOutlet UIButton *star1;
@property (weak, nonatomic) IBOutlet UIButton *star2;
@property (weak, nonatomic) IBOutlet UIButton *star3;
@property (weak, nonatomic) IBOutlet UIButton *star4;
@property (weak, nonatomic) IBOutlet UIButton *star5;
@property (weak, nonatomic) IBOutlet UITextField *tfWord;
@property (weak, nonatomic) IBOutlet UIButton *pkCity;
@property (weak, nonatomic) IBOutlet UIButton *btnFilter;
@property (strong,nonatomic) NSMutableArray *stars;
@property int preN;
@property int postN;

@end
