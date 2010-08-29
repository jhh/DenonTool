//
//  DenonTool.h
//  DenonTool
//
//  Created by Jeff Hutchison on 8/22/10.
//  Copyright (c) 2010 Jeff Hutchison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRSession+Commands.h"
@class DenonState;

@interface DenonTool : NSObject <DRSessionDelegate> {
}

@property (assign, nonatomic) DRSession *session;
@property (assign, nonatomic) DenonState *state;

- (void) run;
- (void) shutDown;

#pragma mark DRSessionDelegate Methods
- (void) session:(DRSession *)session didReceiveEvent:(DREvent *)event;
- (void) session:(DRSession *)session didFailWithError:(NSError *)error;


@end
