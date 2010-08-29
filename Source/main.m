//
//  main.m
//  DenonTool
//
//  Created by Jeff Hutchison on 8/28/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DenonTool.h"
#import "DenonState.h"
#import "DefaultFormatter.h"

int main (int argc, const char * argv[]) {

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    DenonTool* tool = [[DenonTool alloc] init];
    tool.state = [[DenonState alloc] init];
    [tool run];
    [tool shutDown];
    DefaultFormatter * formatter = [[DefaultFormatter alloc] initWithState:tool.state];
    [formatter writeToStandardOutput];
    [pool drain];
    return 0;
}

