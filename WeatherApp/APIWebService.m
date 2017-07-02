//
//  APIWebService.m
//  WeatherApp
//
//  Created by Sai Teja on 6/10/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import "APIWebService.h"

@implementation APIWebService

NSString *URL_Key = @"**************";

NSString *URLString = @"http://api.wunderground.com/api/URL_Key/forecast/q";


-(NSURLRequest*)createRequestwithURL:(NSString*)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    return request;
}

- ( NSURLSession * )getURLSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
   
    dispatch_once( &onceToken,
                  ^{
                      NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                      session = [NSURLSession sessionWithConfiguration:configuration];
                  } );
    
    return session;
}



-(void)getTemparatures:(NSString*)city respectiveState:(NSString*)state onSuccess:(void (^)(NSDictionary *))onSuccess onError:(void (^)(NSError *))onError;
{
    
    //creating a URL to make a request
    NSURL *URL = [self getURLwithString:city respectiveState:state];
    
    //creating a request object to perform on the URL
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:URL];
    
    //perform the data task to download the data
    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:request completionHandler:^( NSData *data, NSURLResponse *response, NSError *error ) {
                                      
        // parse returned JSON array
        NSDictionary *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (parsedJSONArray != nil) {
            onSuccess(parsedJSONArray);
        }else {
            onError(error);
        }
        
        
    }];
    
    [task resume];
    
}

-(NSURL *)getURLwithString:(NSString*)city respectiveState:(NSString*)state {
    
    NSString *subStr;
    
    if (state.length > 3) {
        subStr = [state substringToIndex:4];
    }else {
        subStr = state;
    }
    
    NSString *apiURLString = [URLString stringByAppendingFormat:@"/%@/%@.json", [subStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]], [city stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    
    return [NSURL URLWithString:apiURLString];
    
}

@end
