//
//  APIWebService.h
//  WeatherApp
//
//  Created by Sai Teja on 6/10/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIWebService : NSObject


-(void)getTemparatures:(NSString*)city respectiveState:(NSString*)state onSuccess:(void (^)(NSDictionary *))onSuccess onError:(void (^)(NSError *))onError;


@end
