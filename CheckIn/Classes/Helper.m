//
//  Helper.m
//  CheckIn
//
//  Created by Raja Rao DV on 2/5/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import "Helper.h"

@implementation Helper

- (void)animateLabel:(UILabel *) label  withText: (NSString *) text withBackgroundColor:(UIColor*) backgroundColor {
    
    if(backgroundColor != nil) {
        label.backgroundColor = [UIColor orangeColor];
    }
    
    if(text != nil) {
        label.text = text;
    }
    
    [label setAlpha:0.0];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void)
     {
         [label setAlpha:1.0];
     }
    completion:^(BOOL finished)
    {
         if(finished)
         {
             [UIView animateWithDuration:1.5
                                   delay:3
                                 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                              animations:^(void)
              {
                  [label setAlpha:0.0];
              }
                              completion:^(BOOL finished)
              {
                  if(finished)
                      NSLog(@"Hurray. Label fadedIn & fadedOut");
              }];
         }
     }];
}

@end
