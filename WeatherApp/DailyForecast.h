//
//  DailyForecast.h
//  WeatherApp
//
//  Created by Sai Teja on 6/11/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Forecast.h"

@interface DailyForecast : UIView

- (void)configureBlock:(Forecast*)forecast index:(float)index;

@end
