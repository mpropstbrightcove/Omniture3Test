//
//  SampleVideoLibrary.m
//  SampleVideoLibrary
//
//  Created by Matt Propst on 1/16/14.
//  Copyright (c) 2014 Matt Propst. All rights reserved.
//

#import "SampleVideoLibrary.h"

@implementation SampleVideoLibrary

NSString *const TRACKING_RSID =   @"rsid_value_sample_app";
NSString *const TRACKING_SERVER = @"http://www.foo_app.com";


- (MPMoviePlayerController*)createMPMoviePlayerWithVideo:(NSURL *)url{
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];

    [self setupOmniture];
    NSLog(@"Player: %@", self.player);
    return self.player;
}

- (void)setupOmniture{
    ADMS_Measurement *measurement = [ADMS_Measurement sharedInstance];
    [measurement configureMeasurementWithReportSuiteIDs:TRACKING_RSID
                                         trackingServer:TRACKING_SERVER];
    
    //Set Additional Configuration Variables Here
    measurement.ssl = NO;
    measurement.debugLogging = YES;
    
    //Setup media measurement
    ADMS_MediaMeasurement *mediaMeasure = [ADMS_MediaMeasurement sharedInstance];
    
    NSDictionary *_milestoneMappingDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           @"event4",@"25",
                                           @"event5", @"50",
                                           @"event6", @"75",
                                           nil];
    NSDictionary *_offsetMilestoneMappingDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                                 @"event8",@"20",
                                                 @"event9", @"40",
                                                 @"event10", @"60",
                                                 nil];
    
    

    mediaMeasure.contextDataMapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"eVar2,prop2",@"a.media.name",
                                       @"eVar3",@"a.media.segment",
                                       @"eVar1",@"a.contentType",
                                       @"event3",@"a.media.timePlayed",
                                       @"event1",@"a.media.view",
                                       @"event2",@"a.media.segmentView",
                                       @"event7",@"a.media.complete",
                                       _milestoneMappingDict, @"a.media.milestones",
                                       _offsetMilestoneMappingDict, @"a.media.offsetMilestones",
                                       nil];
    
    //Track By Milestones:
    mediaMeasure.trackMilestones = @"25,50,75";
    
    //Track Video
    [mediaMeasure setAutoTrackingOptions:ADMS_MediaAutoTrackOptionsMPMoviePlayer];
}

#pragma mark - delegate methods

- (void)ADMS_MediaMeasurementMonitor:(ADMS_Measurement *)measurement media:(ADMS_MediaState *)media
{
    NSLog(@"VMNOmniture: %@ percent %f%%, offset %f, segment length %f, time played %f, media length %f", [media mediaEvent], media.percent, media.offset, media.segmentLength, media.timePlayed, media.length);
    [measurement configureMeasurementWithReportSuiteIDs:TRACKING_RSID
                                         trackingServer:TRACKING_SERVER];
    //Test Setting Props/Evars Explicitly
    [[ADMS_Measurement sharedInstance] setProp:1 toValue:@"prop1-videoLibraryOnMediaMeasurement"];
    [[ADMS_Measurement sharedInstance] setEvar:1 toValue:@"evar1-videoLibraryOnMediaMeasurement"];
    
    [[ADMS_Measurement sharedInstance] setProp:2 toValue:@"prop2-videoLibraryOnMediaMeasurement"];
    [[ADMS_Measurement sharedInstance] setEvar:2 toValue:@"evar2-videoLibraryOnMediaMeasurement"];

    
}


@end
