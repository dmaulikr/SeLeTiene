//
//  Filter.h
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject{
    int typeFil;
    int cityId;
    NSString *cityName;
    NSString *keyWord;
    int stars;
}

//Getters
-(int)getTypeFil;
-(int)getCityId;
-(NSString*)getCityName;
-(NSString*)getKeyWord;
-(int)getStars;

//Setters
-(void)setTypeFil:(int)typeFilN;
-(void)setCityId:(int)cityIdN;
-(void)setCityName:(NSString*)cityNameN;
-(void)setKeyWord:(NSString*)keyWordN;
-(void)setStars:(int)starsN;


@end
