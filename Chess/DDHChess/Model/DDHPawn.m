//
//  DDHPawn.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPawn.h"

@implementation DDHPawn
{
    BOOL hasNotMoved;
}
/*
-(id) initWithPlayer:(ChessPlayer) player andIndex:(int) index atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super initWithPlayer:player andIndex:index atColumn:column andRow:row];
    hasNotMoved = YES;
    return self;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDH2DArray *)board
{
    if (hasNotMoved) {
        // Make pawn highlight two squares in front...
    }
    
    NSInteger column = [self x];
    NSInteger row = [self y];
    
    NSInteger verticalMove = row + pow(-1, [self getPlayer]);
    NSInteger leftMove = column - 1 > 0 ? column - 1 : column;
    NSInteger rightMove = column + 1 < [_board columns] ? column + 1 : column;
    
    
    // Check if the pawn can attack an enemy?
    if ([_board objectAtColumn:rightMove andRow:verticalMove] == ) {
        <#statements#>
    }
    
    return nil;
}

-(void) moveToColumn:(NSInteger)column andRow:(NSInteger)row
{
    if (hasNotMoved)
    {
        hasNotMoved = NO;
    }
    [self setX:column];
    [self setY:row];
}
*/

// F
- (NSString*) description
{
    if ([self getPlayer] == ChessPlayerBlack)
        return @"BlackPawn";
    return @"WhitePawn";
}

@end
