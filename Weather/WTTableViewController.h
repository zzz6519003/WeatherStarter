//
//  WTTableViewController.h
//  Weather
//
//  Created by Scott on 26/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherHTTPClient.h"

@interface WTTableViewController : UITableViewController <NSXMLParserDelegate, CLLocationManagerDelegate, UIActionSheetDelegate, WeatherHttpClientDelegate>

- (IBAction)clear:(id)sender;

- (IBAction)jsonTapped:(id)sender;
- (IBAction)plistTapped:(id)sender;
- (IBAction)xmlTapped:(id)sender;
- (IBAction)httpClientTapped:(id)sender;
- (IBAction)apiTapped:(id)sender;

@property(strong) NSMutableDictionary *xmlWeather; //package containing the complete response
@property(strong) NSMutableDictionary *currentDictionary; //current section being parsed
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property(strong) NSMutableString *outstring;

@property (strong) CLLocationManager *manager;

@end
