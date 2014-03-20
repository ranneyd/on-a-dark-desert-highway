//
//  DDHTuple.m
//  DDHChess
//
//  Created by Dustin Kane on 2/27/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHTuple.h"

@implementation DDHTuple

-(id) initWithX: (NSInteger) x andY:(NSInteger) y
{
    DDHTuple* me = [[DDHTuple alloc] init];
    [me setX:x];
    [me setY: y];
    return me;
}

-(NSString*) description{
    return [NSString stringWithFormat:@"(%d,%d)", [self x], [self y]];
}

@end
