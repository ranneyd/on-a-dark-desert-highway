//
//  DDHPlayer.m
//  Chess
//
//  Created by Dustin Kane on 2/14/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPlayer.h"

@implementation DDHPlayer

const int WHITE = 0;
const int BLACK = 1;

+(id) newPlayer:(int)color{
    id newPlayer = [[self alloc] init];
    [newPlayer setColorValue:color];
    return newPlayer;
}

@end
