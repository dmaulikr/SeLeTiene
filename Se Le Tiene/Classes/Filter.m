//
//  Filter.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "Filter.h"

@implementation Filter

-(id)init{
    self = [super init];
    if (self) {
        typeFil = 0;
        cityId = 0;
        cityName = @"";
        keyWord = @"";
        stars = 0;
    }
    return self;
}


//Getters
-(int)getTypeFil{
    return typeFil;
}
-(int)getCityId{
    return cityId;
}
-(NSString*)getCityName{
    return cityName;
}
-(NSString*)getKeyWord{
    return keyWord;
}
-(int)getStars{
    return stars;
}

//Setters
-(void)setTypeFil:(int)typeFilN{
    typeFil = typeFilN;
}
-(void)setCityId:(int)cityIdN{
    cityId = cityIdN;
}
-(void)setCityName:(NSString*)cityNameN{
    cityName = cityNameN;
}
-(void)setKeyWord:(NSString*)keyWordN{
    keyWord = keyWordN;
}
-(void)setStars:(int)starsN{
    stars = starsN;
}


-(void)setFilter{
    //http://api.seletiene.olinguito.com.co/SeLeTiene.svc/producto?orderby=Stars&page=0&rows=1&query={texto_buscar}
    filterStr = [NSString stringWithFormat:@"&%@",[self getKeyWord]];
}


@end