// DefaultFormatter.m
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

#import "DefaultFormatter.h"
#import "DenonState.h"


@implementation DefaultFormatter

@synthesize state;

- (id)initWithState:(DenonState *)aState {
    if ((self = [super init])) {
        ZAssert(aState != nil, @"State cannot be nil");
        self.state = aState;
    }
    return self;
}

- (NSString *) formattedString {
    NSMutableString *output = [[NSMutableString alloc] initWithString:@"    Receiver power: "];
    
    // STANDBY
    
    if (self.state.standby) {
        [output appendString:@"STANDBY\n"];
        // receiver is in standby, ignore remaining state
         return output;
    } else {
        [output appendString:@"ON\n"];
    }

    // MUTE

    [output appendString:@"              Mute: "];
    if (self.state.muted) {
        [output appendString:@"ON\n"];
    } else {
        [output appendString:@"OFF\n"];
    }
    
    // INPUT SOURCE
    [output appendFormat:@"      Input source: %@\n", self.state.inputSource];
    
    // VOLUME
    [output appendFormat:@"     Master Volume: %g dB\n", self.state.masterVolume];
    [output appendFormat:@" Master Volume Max: %g dB\n", self.state.masterVolumeMax];
    
    // DONE
    
    return output;
}

- (void) writeToStandardOutput {
    NSFileHandle *standardOutput = [NSFileHandle fileHandleWithStandardOutput];
    [self writeToFileHandle:standardOutput];
}

- (void) writeToFileHandle:(NSFileHandle *)fileHandle {
    [fileHandle writeData:[[self formattedString] dataUsingEncoding:NSUTF8StringEncoding]];
}


@end
