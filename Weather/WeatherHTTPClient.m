//
//  WeatherHTTPClient.m
//  Weather
//
//  Created by Snowmanzzz on 3/25/13.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "WeatherHTTPClient.h"
#import "AFJSONRequestOperation.h"

@implementation WeatherHTTPClient

+ (WeatherHTTPClient *)sharedWeatherHTTPClient {
    NSString *urlStr = @"http://free.worldweatheronline.com/feed/";
    static dispatch_once_t pred;
    static WeatherHTTPClient *_sharedWeatherHTTPClient = nil;
    dispatch_once(&pred, ^{
        _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]];
    });
    return _sharedWeatherHTTPClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}

//- (void)updateWeatherLocation:(CLLocation *)location forNumberOfDays:(int)number {
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setObject:[NSString stringWithFormat:@"%d", number] forKey:@"num_of_days"];
//    [parameters setObject:[NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude] forKey:@"q"];
//    [parameters setObject:@"json" forKey:@"format"];
//    [parameters setObject:@"2th7mcsnwy8qbgmd5x549n9u" forKey:@"key"];
//    [self getPath:@"weather.ashx" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)])
//            [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//            [self.delegate weatherHTTPClient:self didFailWithError:error];
//        }
//    }];
//    
//}
- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(int)number{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d",number] forKey:@"num_of_days"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude] forKey:@"q"];
    [parameters setObject:@"json" forKey:@"format"];
    [parameters setObject:@"2th7mcsnwy8qbgmd5x549n9u" forKey:@"key"];
    
    [self getPath:@"weather.ashx"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)])
                  [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)])
                  [self.delegate weatherHTTPClient:self didFailWithError:error];
          }];
}

-(void)weatherHTTPClient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                 message:[NSString stringWithFormat:@"%@",error]
                                                delegate:nil
                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

@end
