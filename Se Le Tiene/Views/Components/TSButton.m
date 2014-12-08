//
//  TSButton.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "TSButton.h"

@implementation TSButton

-(void)awakeFromNib{
    val = false;
    [self addTarget:self action:@selector(touched) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched{
    NSLog(@"Touched");
    if (val) {
        [self setState:false];
    }else{
        NSLog(@"Touched false");
        [self setState:true];
    }
}

-(void)setState:(BOOL)stateBtn{
    if (stateBtn) {
        NSLog(@"?????");
        val = true;
        [self setBackgroundImage:[UIImage imageNamed:@"btnFavorite_on"] forState:UIControlStateNormal];
        [self.delegate changeState:true];
    }else{
        val = false;
        [self setBackgroundImage:[UIImage imageNamed:@"btnFavorite_off"] forState:UIControlStateNormal];
        [self.delegate changeState:false];
    }
    
}


@end
