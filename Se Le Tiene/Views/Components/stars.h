//
//  stars.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/13/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@class stars;

@protocol starsDelegate <NSObject>
@optional
- (void) voted:(int)votes;
@end


@interface stars : UIView

@property int type;
@property (strong,nonatomic) NSMutableArray *stars;
@property (strong,nonatomic) UIImageView *star1;
@property (strong,nonatomic) UIImageView *star2;
@property (strong,nonatomic) UIImageView *star3;
@property (strong,nonatomic) UIImageView *star4;
@property (strong,nonatomic) UIImageView *star5;


@property (strong,nonatomic) UIButton *btn1;
@property (strong,nonatomic) UIButton *btn2;
@property (strong,nonatomic) UIButton *btn3;
@property (strong,nonatomic) UIButton *btn4;
@property (strong,nonatomic) UIButton *btn5;


-(void)setStarsNum:(int)stars;
-(void)eraseEverything;

@property (nonatomic, weak) id <starsDelegate> delegate;

@end
