//
//  Forecast.h
//  WeatherApp
//
//  Created by Sai Teja on 6/11/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject

@property NSString *day;
@property NSString *highTemp;
@property NSString *lowTemp;
@property NSString *textDescription;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
