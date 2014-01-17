//
//  ViewController.m
//  Omniture3SampleTestProject
//
//  Created by Matt Propst on 1/14/14.
//  Copyright (c) 2014 Matt Propst. All rights reserved.
//

#import "ViewController.h"
//#import "StaticLibraryProject.h"
#import "TrackingHelper.h"
#import "SampleVideoLibrary.h"
#import "AnalyticsTracker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TrackingHelper configureAppMeasurement];
    //SETUP OMNITURE FOR APP
    //[TrackingHelper configureAppMeasurement];
    //[TrackingHelper configureMediaMeasurement];
    
	// Do any additional setup after loading the view, typically from a nib.
        [self setupAppButtons];
    NSDictionary *analyticsInfoDict = @{ };
    [AnalyticsTracker logEvent:@"ViewLoaded"
                        onPage:@"MainPage"
                     inSection:@"none"
                withParameters:analyticsInfoDict];
    [self setupStaticLibButtons];
}

- (void)setupAppButtons{
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 380, 275, 30)];
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(20, 415, 275, 30)];
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(20, 450, 275, 30)];
    
    [btn1 setBackgroundColor:[UIColor blackColor]];
    [btn2 setBackgroundColor:[UIColor blackColor]];
    [btn3 setBackgroundColor:[UIColor blackColor]];
    
    [btn1 setTitle:@"Send App Event 1" forState:UIControlStateNormal];
    [btn2 setTitle:@"Send App Event 2" forState:UIControlStateNormal];
    [btn3 setTitle:@"Send App Event 3" forState:UIControlStateNormal];
    
    [btn1 addTarget:self action:@selector(btn1AppClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btn2AppClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(btn3AppClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
}


- (void)setupStaticLibButtons{
    NSDictionary *analyticsInfoDict = @{ };
    [AnalyticsTracker logEvent:@"SetupStaticLibraryButtons"
                        onPage:@"MainPage"
                     inSection:@"none"
                withParameters:analyticsInfoDict];
    
    UILabel *staticLibBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 275, 30)];
        [staticLibBtnLabel setText:@"Static Library Omniture Instance"];
    [self.view addSubview:staticLibBtnLabel];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 240, 275, 30)];
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(20, 275, 275, 30)];
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(20, 310, 275, 30)];
    
    [btn1 setBackgroundColor:[UIColor blueColor]];
    [btn2 setBackgroundColor:[UIColor blueColor]];
    [btn3 setBackgroundColor:[UIColor blueColor]];
    
    [btn1 setTitle:@"Load Video 1" forState:UIControlStateNormal];
    [btn2 setTitle:@"Load Video 2" forState:UIControlStateNormal];
    [btn3 setTitle:@"Load Video 3" forState:UIControlStateNormal];
    
    [btn1 addTarget:self action:@selector(btn1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btn2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(btn3Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
}

#pragma mark - Buttons for App Events
- (void)btn1AppClicked{
    NSDictionary *analyticsInfoDict = @{ };
    [AnalyticsTracker logEvent:@"App_Button_1_Clicked"
                        onPage:@"MainPage"
                     inSection:@"none"
                withParameters:analyticsInfoDict];
}

- (void)btn2AppClicked{
    NSDictionary *analyticsInfoDict = @{ };
    [AnalyticsTracker logEvent:@"App_Button_2_Clicked"
                        onPage:@"MainPage"
                     inSection:@"none"
                withParameters:analyticsInfoDict];
}

- (void)btn3AppClicked{
    NSDictionary *analyticsInfoDict = @{ };
    [AnalyticsTracker logEvent:@"App_Button_3_Clicked"
                        onPage:@"MainPage"
                     inSection:@"none"
                withParameters:analyticsInfoDict];
}

#pragma mark - Buttons for Static Library Events
- (void)btn1Clicked{
    NSDictionary *analyticsInfoDict = @{ };
    [AnalyticsTracker logEvent:@"Button1Clicked"
                          onPage:@"MainPage"
                     inSection:@"none"
                  withParameters:analyticsInfoDict];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample_mpeg4" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    if(self.player != nil);
    [self.player.view removeFromSuperview];
    self.player = nil;
    
    SampleVideoLibrary *svl = [[SampleVideoLibrary alloc] init];
    self.player = [svl createMPMoviePlayerWithVideo:url];
    [self.player prepareToPlay];
    [self.player.view setFrame:CGRectMake(0, 0, 320, 180)];
    
    [self.view addSubview:self.player.view];
    [self.player play];
}

- (void)btn2Clicked{
    NSDictionary *analyticsInfoDict = @{ };
    [AnalyticsTracker logEvent:@"Button2Clicked"
                        onPage:@"MainPage"
                     inSection:@"none"
                withParameters:analyticsInfoDict];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"big-buck-bunny" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    if(self.player != nil);
    [self.player.view removeFromSuperview];
    self.player = nil;
    
    SampleVideoLibrary *svl = [[SampleVideoLibrary alloc] init];
    self.player = [svl createMPMoviePlayerWithVideo:url];
    [self.player prepareToPlay];
    [self.player.view setFrame:CGRectMake(0, 0, 320, 180)];
    
    [self.view addSubview:self.player.view];
    [self.player play];
}

- (void)btn3Clicked{
    NSDictionary *analyticsInfoDict = @{ };
    [AnalyticsTracker logEvent:@"Button3Clicked"
                        onPage:@"MainPage"
                     inSection:@"none"
                withParameters:analyticsInfoDict];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"fridayafternext_http" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    if(self.player != nil);
    [self.player.view removeFromSuperview];
    self.player = nil;
    
    SampleVideoLibrary *svl = [[SampleVideoLibrary alloc] init];
    self.player = [svl createMPMoviePlayerWithVideo:url];
    [self.player prepareToPlay];
    [self.player.view setFrame:CGRectMake(0, 0, 320, 180)];
    
    [self.view addSubview:self.player.view];
    [self.player play];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
