//
//  SampleVideoLibrary.h
//  SampleVideoLibrary
//
//  Created by Matt Propst on 1/16/14.
//  Copyright (c) 2014 Matt Propst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ADMS_MediaMeasurement.h"

@interface SampleVideoLibrary : NSObject<ADMS_MediaMeasurementDelegate>
@property (strong) MPMoviePlayerController *player;

//Method takes a URL to video and returns a MPMoviePlayerController with Omniture setup
- (MPMoviePlayerController*)createMPMoviePlayerWithVideo:(NSURL *)url;

@end
