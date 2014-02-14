//
//  DDHLoc.h
//  Chess
//
//  Created by Dustin Kane on 2/14/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>


//This class could not be more simple. Couldn't find a Point object in Objective C
@interface DDHLoc : NSObject

@property int x;
@property int y;

+(id) newPosAtX:(int) x andY: (int) y;

@end
