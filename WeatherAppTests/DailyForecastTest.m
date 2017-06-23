//
//  DailyForecastTest.m
//  WeatherApp
//
//  Created by Sai Teja on 6/12/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DailyForecast.h"

@interface DailyForecastTest : XCTestCase

@end

@implementation DailyForecastTest {
    DailyForecast *dailyForecast;
}

- (void)setUp {
    [super setUp];
    
    dailyForecast = [[DailyForecast alloc]init];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

-(void)create_View_Frame {
    DailyForecast *tempDailyForecast = [[DailyForecast alloc]initWithFrame:CGRectMake(0, 5, 10, 10)];
    
    if (dailyForecast) {
        XCTAssertEqual(dailyForecast, tempDailyForecast, @"Object created ");
    }else {
        XCTAssertNil(tempDailyForecast, @"Object Not Created");
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
