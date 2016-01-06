//
//  MenuView.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/12/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView
@synthesize find,add,profile;

- (instancetype)init {
    NSLog(@"Hola mundo");
    return nil;
}

-(void)awakeFromNib{
    double sw = self.bounds.size.width/3;
    
    find = [UIButton buttonWithType:UIButtonTypeSystem];
    find.frame = CGRectMake(0, 5, 0, 60);
    [find setImage:[UIImage imageNamed:@"btnSearchMenu"] forState:UIControlStateNormal];
    find.tintColor = [UIColor whiteColor];
    find.tag = 1;
    find.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:find];
    
    add = [UIButton buttonWithType:UIButtonTypeSystem];
    add.frame = CGRectMake(sw, 5, sw, 60);
    [add setImage:[UIImage imageNamed:@"btnAddMenu"] forState:UIControlStateNormal];
    add.tintColor = [UIColor whiteColor];
    add.tag = 2;
    add.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:add];
    
    profile = [UIButton buttonWithType:UIButtonTypeSystem];
    profile.frame = CGRectMake(sw*2, 5, sw, 60);
    [profile setImage:[UIImage imageNamed:@"btnUserMenu"] forState:UIControlStateNormal];
    profile.tintColor = [UIColor whiteColor];
    profile.tag = 3;
    profile.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:profile];
    
    [find addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    [add addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    [profile addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addConstraints];
}

-(void) addConstraints{
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.find
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.find
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:5]];
    
    [self.find addConstraint:
     [NSLayoutConstraint constraintWithItem:self.find
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:60]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.add
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.find
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.add
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:5]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.add
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.find
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1
                                   constant:0]];
    
    [self.add addConstraint:
     [NSLayoutConstraint constraintWithItem:self.add
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:60]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.profile
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.add
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.profile
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.profile
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:5]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.profile
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.add
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1
                                   constant:0]];
    
    [self.profile addConstraint:
     [NSLayoutConstraint constraintWithItem:self.profile
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:60]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.find
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.profile
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1
                                   constant:0]];
    
}

-(IBAction)touched:(id)sender{
    UIButton *btnTmp = sender;
    switch (btnTmp.tag) {
        case 1:
            [self.delegate fiendView];
        break;
        case 2:
            [self.delegate addView];
        break;
        case 3:
            [self.delegate profileView];
        break;
    }
}

-(void)setButton:(int)btn{
    switch (btn) {
        case 1:
            find.tintColor = [UIColor colorWithRed:0.263 green:0.596 blue:0.804 alpha:1];
        break;
        case 2:
            add.tintColor = [UIColor colorWithRed:0.263 green:0.596 blue:0.804 alpha:1];
        break;
        case 3:
            profile.tintColor = [UIColor colorWithRed:0.263 green:0.596 blue:0.804 alpha:1];
        break;
    }
}

@end
