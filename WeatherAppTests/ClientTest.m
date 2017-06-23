//
//  ClientTest.m
//  WeatherApp
//
//  Created by Sai Teja on 6/12/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIWebService.h"
@interface ClientTest : XCTestCase

@end

@implementation ClientTest {
    APIWebService *weatherClient;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    weatherClient = [[APIWebService alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_should_retrieve_a_weather_report_given_a_valid_city
{
    
    __block NSDictionary *weatherData;
    
    [weatherClient getTemparatures:@"San Francisco" respectiveState:@"CA" onSuccess:^(NSDictionary *dictionary) {
        weatherData = dictionary;
    } onError:^(NSError *error) {
        XCTAssertNil(weatherData, @"Found Nil");
    }];
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    __block NSDictionary *weatherData;
    
    [self measureBlock:^{
        [weatherClient getTemparatures:@"San Francisco" respectiveState:@"CA" onSuccess:^(NSDictionary *dictionary) {
            weatherData = dictionary;
        } onError:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }];
}

@end
