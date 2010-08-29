//
//  DefaultFormatter.h
//  DenonTool
//
//  Created by Jeff Hutchison on 8/22/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DenonState;


@interface DefaultFormatter : NSObject {

}

@property (assign, nonatomic) DenonState *state;

- (id)initWithState:(DenonState *)aState;
- (NSString *) formattedString;
- (void) writeToStandardOutput;
- (void) writeToFileHandle:(NSFileHandle *)fileHandle;

@end
