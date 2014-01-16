//
//  SampleVideoLibrary.m
//  SampleVideoLibrary
//
//  Created by Matt Propst on 1/16/14.
//  Copyright (c) 2014 Matt Propst. All rights reserved.
//

#import "SampleVideoLibrary.h"

@implementation SampleVideoLibrary


- (MPMoviePlayerController*)createMPMoviePlayerWithVideo:(NSURL *)url{
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];

    [self setupOmniture];
    NSLog(@"Player: %@", self.player);
    return self.player;
}

- (void)setupOmniture{
    NSString *const TRACKING_RSID =   @"YOUR_RSID_HERE";
    NSString *const TRACKING_SERVER = @"YOUR_SERVER_HERE";
    
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

@end
