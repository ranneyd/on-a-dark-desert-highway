//
//  DDHLoc.m
//  Chess
//
//  Created by Dustin Kane on 2/14/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHLoc.h"

@implementation DDHLoc

+(id) newPosAtX:(int)x andY:(int)y
{
    id newPos = [[self alloc] init];
    [newPos setX:x];
    [newPos setY:y];
    return newPos;
}

@end
