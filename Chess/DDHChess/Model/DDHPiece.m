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

-(id) initWithPlayer:(ChessPlayer) player andIndex:(int) index atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super init];
    [self setIndex:index];
    [self moveToColumn:column andRow:row];
    _owner = player;
    return self;
}

-(BOOL**) highlightMovesWithBoard:(DDH2DArray *)board
{
    // To be overridden
    return nil;
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

-(BOOL) onBoard:(DDH2DArray*)board AtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return column < 0 || column >= [board columns] || row < 0 || row >= [board rows];
}


@end
