//
//  stars.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/13/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface stars : UIView


@property (strong,nonatomic) NSMutableArray *stars;
@property (strong,nonatomic) UIImageView *star1;
@property (strong,nonatomic) UIImageView *star2;
@property (strong,nonatomic) UIImageView *star3;
@property (strong,nonatomic) UIImageView *star4;
@property (strong,nonatomic) UIImageView *star5;


-(void)setStarsNum:(int)stars;
-(void)eraseEverything;

@end
