//
//  MenuView.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/12/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MenuView;

@protocol MenuViewDelegate <NSObject>
@optional
- (void) fiendView;
- (void) addView;
- (void) profileView;
@end


@interface MenuView : UIView

@property (strong,nonatomic) UIButton *find;
@property (strong,nonatomic) UIButton *add;
@property (strong,nonatomic) UIButton *profile;
@property (nonatomic, weak) id <MenuViewDelegate> delegate;


-(void)setButton:(int)btn;

@end
