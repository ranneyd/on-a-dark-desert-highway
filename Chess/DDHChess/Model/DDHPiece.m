//
//  DDHPiece.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPiece.h"

@implementation DDHPiece
{
    ChessPlayer _owner;
}

-(id) initWithBoard:(id)board andPlayer:(ChessPlayer) player andIndex:(int) index atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super init];
    [self setBoard:board];
    [self setIndex:index];
    [self moveToColumn:column andRow:row];
    _owner = player;
    return self;
}

-(void) highlightMoves
{
    // To be overridden 
}
-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self setX:column];
    [self setY:row];
}
-(ChessPlayer)getPlayer
{
    return _owner;
}

@end
