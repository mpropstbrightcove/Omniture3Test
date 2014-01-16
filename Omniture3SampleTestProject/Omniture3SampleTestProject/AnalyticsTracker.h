//
//  AnalyticsTracker.h
//  Omniture3SampleTestProject
//
//  Created by Matt Propst on 1/16/14.
//  Copyright (c) 2014 Matt Propst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalyticsTracker : NSObject

+ (void)logEvent:(NSString *)eventName
          onPage:(NSString *)pageName
       inSection:(NSString *)sectionName
  withParameters:(NSDictionary *)parameters;

@end
