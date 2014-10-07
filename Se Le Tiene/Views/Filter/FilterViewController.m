//
//  FilterViewController.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/6/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize star1,star2,star3,star4,star5,preN,postN,btnFilter;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stars = [[NSMutableArray alloc] initWithCapacity:5];
    [self.stars addObject:star1];
    [self.stars addObject:star2];
    [self.stars addObject:star3];
    [self.stars addObject:star4];
    [self.stars addObject:star5];
    preN = 0;
    self.title = @"Filtrar búsqueda";
    
    btnFilter.layer.cornerRadius = 5.0f;
}

-(void)setStar:(int)numStars{
    int s = preN==numStars ? 0 : numStars;
    for (int i = 0; i<[self.stars count]; i++) {
        if (i<s) {
            [(UIButton*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"btnStar_on"] forState:UIControlStateNormal];
        }else{
            [(UIButton*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"btnStar"] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)setStarT:(id)sender {
    UIButton *tmp = sender;
    [self setStar:tmp.tag];
    preN = tmp.tag;
}

- (IBAction)applyFilters:(id)sender {
    
}


@end
