//
//  Forecast.m
//  WeatherApp
//
//  Created by Sai Teja on 6/11/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    NSLog(@"%@", dictionary);
    if (self)
    {
        self.day = dictionary[@"date"][@"weekday_short"];
        self.highTemp = dictionary[@"high"][@"fahrenheit"];
        self.lowTemp = dictionary[@"low"][@"fahrenheit"];
        self.textDescription = dictionary[@"conditions"];
    }
    
    return self;
}

@end
