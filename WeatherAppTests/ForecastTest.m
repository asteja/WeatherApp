//
//  ForecastTest.m
//  WeatherApp
//
//  Created by Sai Teja on 6/12/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Forecast.h"

@interface ForecastTest : XCTestCase

@end

@implementation ForecastTest {
    Forecast *forecast;
    NSDictionary *dictionary;
    }

- (void)setUp {
    [super setUp];
    dictionary = [[NSDictionary alloc]init];
    
    

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)create_Forecast_object
{
    forecast = [[Forecast alloc]init];
    
    if (forecast) {
        XCTAssertNotNil(forecast, @"object created");
    } else {
        XCTAssertNil(forecast, @"unable to create a object");
    }
   
    forecast = [[Forecast alloc]initWithDictionary:dictionary];
   
    if (forecast) {
        XCTAssertNotNil(forecast, @"object created");
    } else {
        XCTAssertNil(forecast, @"unable to create a object due to dicionary is nil");
    }
    
}




- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        forecast = [[Forecast alloc]initWithDictionary:dictionary];
    }];
}

@end
