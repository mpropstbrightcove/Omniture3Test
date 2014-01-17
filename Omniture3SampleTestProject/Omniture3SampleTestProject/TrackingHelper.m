//
//  TrackingHelper.m
//  Adobe Digital Marketing Suite
//

#import "TrackingHelper.h"
#import "ADMS_Measurement.h"
#import "ADMS_MediaMeasurement.h"

NSString *const TRACKING_APP_RSID =	@"rsid_value_sample_app";
NSString *const TRACKING_APP_SERVER = @"http://www.foo_app.com";

@implementation TrackingHelper

+ (void)configureAppMeasurement{
	ADMS_Measurement *measurement = [ADMS_Measurement sharedInstance];
    [measurement configureMeasurementWithReportSuiteIDs:TRACKING_APP_RSID
                                             trackingServer:TRACKING_APP_SERVER];
    
    measurement.debugLogging = NO;
	measurement.offlineTrackingEnabled = NO;
	measurement.lifecycleSessionTimeout = 5 * 60;	// force the session to be new on every app activation (including foregrounding)
    //    measurement.offlineHitLimit = 1000; //Keep this under 5000
    
    NSMutableDictionary *contextData = [NSMutableDictionary dictionary];
    [contextData setObject:@"iOS" forKey:@"appId"];
    [measurement setPersistentContextData:contextData];
	
}

// track custom event(s)
+ (void)trackCustomEvents:(NSString *)events {
    ADMS_Measurement *measurement = [ADMS_Measurement sharedInstance];

	NSMutableDictionary *contextData = [NSMutableDictionary dictionary];
	[contextData setObject:@"value" forKey:@"contextKey"];
	
	[measurement trackEvents:events withContextData:contextData];
}

// track custom app state(s)
+ (void)trackCustomAppState:(NSString *)appState {	
	NSMutableDictionary *contextData = [NSMutableDictionary dictionary];
	[contextData setObject:@"value" forKey:@"contextKey"];
}


+ (void)configureMediaMeasurement{
    NSLog(@"--Configure Media Measurement In App -- ");
	ADMS_MediaMeasurement *mediaMeasurement = [ADMS_MediaMeasurement sharedInstance];
    
    //Configure ContextDataMapping(required)	
    mediaMeasurement.contextDataMapping = [@{
        @"a.media.name":@"eVar2,prop2",
        @"a.media.segment":@"eVar3",
        @"a.media.segment":@"eVar4",
        @"a.media.segment":@"eVar5",
        @"a.media.segment":@"eVar6",
        @"a.contentType":@"eVar1",
        @"a.media.timePlayed":@"event3",
        @"a.media.view":@"event1",
        @"a.media.segmentView":@"event2",
        @"a.media.complete":@"event7"
    } mutableCopy];
    
    //Configure optional settings
    mediaMeasurement.trackMilestones = @"5,10,15,25,50,75";
    mediaMeasurement.segmentByMilestones = YES;
    
    [mediaMeasurement open:@"fakeOpen" length:60 playerName:@"fakePlayerName"];
    NSLog(@"Fake Open Sent");
    [mediaMeasurement setTrackVars:@"vars"];
    [mediaMeasurement setTrackEvents:@"events"];
//    NSString *trackVars = [trackVarsArray componentsJoinedByString:@","];
//    [mediaMeasurement setTrackVars:trackVars];
//    [mediaMeasurement setTrackEvents:nil];
}

// Tracking Events

+ (void)trackEventWithFullContextData:(NSDictionary *)contextDataDict {
    // Get tracking dictionary
    NSMutableDictionary *trackingDict = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                @"previous_page": @"None",
                                                                @"visited_pages": [[NSMutableDictionary alloc] init]
                                                                                    }];
    
    // Add custom context variables
    NSMutableDictionary *contextDict = [NSMutableDictionary dictionaryWithDictionary:contextDataDict];
    [contextDict setObject: [TrackingHelper dayOfWeek] forKey:@"day_of_week"];
    [contextDict setObject: [TrackingHelper hourOfDay] forKey:@"hour_of_day"];
    [contextDict setObject: [TrackingHelper timestamp] forKey:@"timestamp"]; //removed 2/3/13
    [contextDict setObject: [trackingDict objectForKey:@"previous_page"] forKey:@"previous_page"];
    
    // Send tracking call
    [[ADMS_Measurement sharedInstance] configureMeasurementWithReportSuiteIDs:TRACKING_APP_RSID
                                         trackingServer:TRACKING_APP_SERVER];
    
    [[ADMS_Measurement sharedInstance] trackEvents:@"event16" withContextData:contextDict];
    
    //Test Setting Props
    [[ADMS_Measurement sharedInstance] setProp:1 toValue:@"prop1-app"];
    [[ADMS_Measurement sharedInstance] setProp:2 toValue:@"prop2-app"];
    [[ADMS_Measurement sharedInstance] setProp:3 toValue:@"prop3-app"];
    
    [[ADMS_Measurement sharedInstance] setEvar:4 toValue:@"evar4-app"];
    [[ADMS_Measurement sharedInstance] setEvar:5 toValue:@"evar5-app"];
    [[ADMS_Measurement sharedInstance] setEvar:6 toValue:@"evar6-app"];
    
    
}

+ (NSString*)dayOfWeek {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"e"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString*)hourOfDay {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"k"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString*)timestamp {
    return [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
}


@end
