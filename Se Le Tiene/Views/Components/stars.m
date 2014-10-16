//
//  stars.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/13/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "stars.h"

@implementation stars
@synthesize star1,star2,star3,star4,star5;

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}


-(void)awakeFromNib{
    self.backgroundColor = [UIColor clearColor];
        NSString *strOff =@"starBig_off";
        self.stars = [[NSMutableArray alloc] initWithCapacity:5];
        double sizeStar = self.frame.size.width/6;
        double sizeStarH = sizeStar/1.08;
        double spacerStar = sizeStar/4;
        double spacerVertical = (self.frame.size.height - sizeStar)/2;
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

-(void)setStarsNum:(int)stars{
    [self eraseEverything];
    for (int i=0; i<stars; i++) {
        [(UIImageView*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"starBig"]];
        
    }
}
-(void)eraseEverything{
    for (int i=0; i<[self.stars count]; i++) {
        [(UIImageView*)[self.stars objectAtIndex:i] setImage:[UIImage imageNamed:@"starBig_off"]];
    }
}

@end
