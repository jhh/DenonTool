//
//  DefaultFormatter.m
//  DenonTool
//
//  Created by Jeff Hutchison on 8/22/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

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
    NSMutableString *output = [[NSMutableString alloc] initWithString:@"Receiver power: "];
    
    // STANDBY
    
    if (self.state.standby) {
        [output appendString:@"STANDBY\n"];
        // receiver is in standby, ignore remaining state
         return output;
    } else {
        [output appendString:@"ON\n"];
    }

    // MUTE

    [output appendString:@"          Mute: "];
    if (self.state.muted) {
        [output appendString:@"ON\n"];
    } else {
        [output appendString:@"OFF\n"];
    }
    
    // INPUT SOURCE
    [output appendFormat:@"  Input source: %@\n", self.state.inputSource];
    
    // VOLUME
    [output appendFormat:@" Master Volume: %g\n", self.state.masterVolume];
    [output appendFormat:@" Master Volume Max: %g\n", self.state.masterVolumeMax];
    
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
