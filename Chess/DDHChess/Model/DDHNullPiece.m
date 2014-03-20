//
//  DDHNullPiece.m
//  DDHChess
//
//  Created by CS121 on 3/2/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHNullPiece.h"

@implementation DDHNullPiece

- (id) init
{
    if (self = [super init]){
        [self setPlayer:ChessPlayerNull];
    }
    return self;
}

-(NSString*) description
{
    return @"NullPiece";
}

@end
