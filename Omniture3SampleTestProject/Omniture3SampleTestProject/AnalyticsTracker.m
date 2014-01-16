//
//  AnalyticsTracker.m
//  Omniture3SampleTestProject
//
//  Created by Matt Propst on 1/16/14.
//  Copyright (c) 2014 Matt Propst. All rights reserved.
//

#import "AnalyticsTracker.h"
#import "TrackingHelper.h"

@implementation AnalyticsTracker
+ (void)logEvent:(NSString *)eventName
          onPage:(NSString *)pageName
       inSection:(NSString *)sectionName
  withParameters:(NSDictionary *)parameters {
    
    NSMutableDictionary *importantInfoDictionary = [[NSMutableDictionary alloc] init];
    [importantInfoDictionary setObject:pageName forKey:@"page_name"];
    [importantInfoDictionary setObject:eventName forKey:@"event_name"];
    
    [importantInfoDictionary addEntriesFromDictionary:parameters];
    
    NSMutableDictionary *contextData = [NSMutableDictionary dictionaryWithDictionary:importantInfoDictionary];
    
    
    NSLog(@"••••••••••••••••••••••••••••••••••••• ANALYTICS: EVENT: '%@' PAGE: '%@' SECTION: '%@' SHOWID: '%@'", eventName, pageName, sectionName, @"sampleApp");
    
    
    //Omniture
    [TrackingHelper trackEventWithFullContextData:contextData];
    
}
@end
