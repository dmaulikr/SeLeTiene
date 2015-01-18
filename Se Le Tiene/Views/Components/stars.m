//
//  stars.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/13/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "stars.h"

@implementation stars
@synthesize star1,star2,star3,star4,star5,btn1,btn2,btn3,btn4,btn5;
@synthesize type = _type;

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}


-(void)awakeFromNib{
    self.backgroundColor = [UIColor clearColor];
    self.stars = [[NSMutableArray alloc] initWithCapacity:5];
    double sizeStar = self.frame.size.width/6;
    double sizeStarH = sizeStar/1.08;
    double spacerStar = sizeStar/4;
    double spacerVertical = (self.frame.size.height - sizeStar)/2;
    
    if (_type == 0) {
        btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, spacerVertical, sizeStar, sizeStarH)];
        btn2 = [[UIButton alloc] initWithFrame:CGRectMake(sizeStar+spacerStar, spacerVertical, sizeStar, sizeStarH)];
        btn3 = [[UIButton alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*2, spacerVertical, sizeStar, sizeStarH)];
        btn4 = [[UIButton alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*3, spacerVertical, sizeStar, sizeStarH)];
        btn5 = [[UIButton alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*4, spacerVertical, sizeStar, sizeStarH)];
        [self.stars addObject:btn1];
        [self.stars addObject:btn2];
        [self.stars addObject:btn3];
        [self.stars addObject:btn4];
        [self.stars addObject:btn5];
    }
    else{
        star1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, spacerVertical, sizeStar, sizeStarH)];
        star2 = [[UIImageView alloc] initWithFrame:CGRectMake(sizeStar+spacerStar, spacerVertical, sizeStar, sizeStarH)];
        star3 = [[UIImageView alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*2, spacerVertical, sizeStar, sizeStarH)];
        star4 = [[UIImageView alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*3, spacerVertical, sizeStar, sizeStarH)];
        star5 = [[UIImageView alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*4, spacerVertical, sizeStar, sizeStarH)];
        [self.stars addObject:star1];
        [self.stars addObject:star2];
        [self.stars addObject:star3];
        [self.stars addObject:star4];
        [self.stars addObject:star5];
    }
    [self initComponents];
}


-(void) initComponents{
    NSString *strOff =@"starBig_off";
    if (_type == 0) {
        for (int i=0; i<[self.stars count]; i++) {
            [(UIButton*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:strOff] forState:UIControlStateNormal];
            [(UIButton*)[self.stars objectAtIndex:i] addTarget:self action:@selector(setNumBtn:) forControlEvents:UIControlEventTouchUpInside];
            ((UIButton*)[self.stars objectAtIndex:i]).tag = i+1;
            [self addSubview:(UIButton*)[self.stars objectAtIndex:i]];
        }
    }else{
        for (int i=0; i<[self.stars count]; i++) {
            [(UIImageView*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:strOff]];
            [self addSubview:(UIImageView*)[self.stars objectAtIndex:i]];
        }
    }
}


-(instancetype)initWithFrame:(CGRect)frame{
    self.backgroundColor = [UIColor clearColor];
    if (self = [super init]) {
        NSString *strOff =@"starBig_off";
        self.stars = [[NSMutableArray alloc] initWithCapacity:5];
        double sizeStar = frame.size.width/6;
        double sizeStarH = sizeStar/1.08;
        double spacerStar = sizeStar/4;
        double spacerVertical = (frame.size.height - sizeStar)/2;
        star1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, spacerVertical, sizeStar, sizeStarH)];
        star1.image =[UIImage imageNamed:strOff];
        star2 = [[UIImageView alloc] initWithFrame:CGRectMake(sizeStar+spacerStar, spacerVertical, sizeStar, sizeStarH)];
        star2.image =[UIImage imageNamed:strOff];
        star3 = [[UIImageView alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*2, spacerVertical, sizeStar, sizeStarH)];
        star3.image =[UIImage imageNamed:strOff];
        star4 = [[UIImageView alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*3, spacerVertical, sizeStar, sizeStarH)];
        star4.image =[UIImage imageNamed:strOff];
        star5 = [[UIImageView alloc] initWithFrame:CGRectMake((sizeStar+spacerStar)*4, spacerVertical, sizeStar, sizeStarH)];
        star5.image =[UIImage imageNamed:strOff];
        
        [self.stars addObject:star1];
        [self.stars addObject:star2];
        [self.stars addObject:star3];
        [self.stars addObject:star4];
        [self.stars addObject:star5];
        
        [self addSubview:star1];
        [self addSubview:star2];
        [self addSubview:star3];
        [self addSubview:star4];
        [self addSubview:star5];
    }
    return self;
}

-(void)setNumBtn:(UIButton*)sender{
    [self eraseEverything];
    for (int i=0; i<sender.tag; i++) {
        [(UIButton*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"starBig"] forState:UIControlStateNormal];
    }
    [self block];
    [self.delegate voted:sender.tag];
}

-(void)block{
    for (int i=0; i<[self.stars count]; i++) {
        ((UIButton*)[self.stars objectAtIndex:i]).userInteractionEnabled = false;
    }
}

-(void)setStarsNum:(int)stars{
    if (_type == 0) {
        [self eraseEverything];
        for (int i=0; i<stars; i++) {
            [(UIButton*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"starBig"] forState:UIControlStateNormal];
        }
    }
    else{
        [self eraseEverything];
        for (int i=0; i<stars; i++) {
            [(UIImageView*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"starBig"]];
            
        }
    }
}
-(void)eraseEverything{
    if (_type == 0) {
        for (int i=0; i<[self.stars count]; i++) {
            [(UIButton*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"starBig_off"] forState:UIControlStateNormal];
        }
    }
    else{
        for (int i=0; i<[self.stars count]; i++) {
            [(UIImageView*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"starBig_off"]];
        }
    }
}

@end
