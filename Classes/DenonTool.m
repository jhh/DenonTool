// DenonTool.m
//
// Copyright 2010 Jeffrey Hutchison
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "DenonTool.h"
#import "DenonState.h"
#import "DREvent.h"

#define RUNLOOP_TIMEOUT 0.2

@implementation DenonTool

@synthesize session;
@synthesize state;

- (id)initWithHost:(NSString *)host {
    if ((self = [super init])) {
        self.session = [[DRSession alloc] initWithHostName:host];
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
