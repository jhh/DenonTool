// DenonTool.h
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
