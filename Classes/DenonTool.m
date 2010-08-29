//
//  DenonTool.m
//  DenonTool
//
//  Created by Jeff Hutchison on 8/22/10.
//  Copyright (c) 2010 Jeff Hutchison. All rights reserved.
//

#import "DenonTool.h"
#import "DenonState.h"
#import "DREvent.h"

#define RUNLOOP_TIMEOUT 0.2

@implementation DenonTool

@synthesize session;
@synthesize state;

- (id)init {
    if ((self = [super init])) {
        self.session = [[DRSession alloc] initWithHostName:@"10.0.1.2"];
        [self.session setDelegate:self];
        self.state = [[DenonState alloc] init];
    }
    return self;
}

- (void) pumpRunLoop {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:RUNLOOP_TIMEOUT]];
}

- (void) run {
    [self.session queryStandby];
    [self pumpRunLoop];

    if (self.state.standby) {
        DLog(@"receiver is in standby, exiting run method");
        return;        
    }

    [self.session queryInputSource];
    [self pumpRunLoop];

    [self.session queryMasterVolume];
    [self pumpRunLoop];
}

- (void) shutDown {
    [self.session close];
    self.session = nil;
}


#pragma mark DRSessionDelegate Methods

- (void)session:(DRSession *)aSession didReceiveEvent:(DREvent *)event {
    assert(aSession == self.session);
    assert(event != nil);

    switch (event.eventType) {
        case DenonPowerEvent:
            self.state.standby = ![event boolValue];
            break;
        case DenonMuteEvent:
            self.state.muted = [event boolValue];
        case DenonInputSourceEvent:
            self.state.inputSource = [event stringValue];
            break;
        case DenonMasterVolumeEvent:
            self.state.masterVolume = [event floatValue];
            break;
        case DenonMasterVolumeMaxEvent:
            self.state.masterVolumeMax = [event floatValue];
            break;
        case DenonVideoSelectModeEvent:
            break;
        default:
            ALog(@"unexpected eventType: %@ - add a new case to switch statement", event);
    }
}


- (void)session:(DRSession *)aSession didFailWithError:(NSError *)error {
    assert(aSession == self.session);
    assert(error != nil);
    DLog(@"%@ received error %@", aSession, error);    
}


@end
