//
//  DenonState.h
//  DenonTool
//
//  Created by Jeff Hutchison on 8/22/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DenonState : NSObject {

}

@property (assign, nonatomic) BOOL      standby;
@property (assign, nonatomic) BOOL      muted;
@property (assign, nonatomic) NSString* inputSource;
@property (assign, nonatomic) float     masterVolume;
@property (assign, nonatomic) float     masterVolumeMax;

@end
