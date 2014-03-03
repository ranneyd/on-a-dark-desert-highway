//
//  DDHPawn.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHPawn.h"
#import "DDHTuple.h"
#import "DDHBoard.h"

@implementation DDHPawn
{
    BOOL hasNotMoved;
}

-(id) initWithPlayer:(ChessPlayer) player atColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    self = [super initWithPlayer:player atColumn:column andRow:row];
    hasNotMoved = YES;
    return self;
}

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board
{
    // Array of moves to be returned
    NSMutableArray* highlighting = [[NSMutableArray alloc] init];
    
    NSInteger column = [self x];
    NSInteger row = [self y];
    
    if (hasNotMoved) {
        // Make pawn highlight two squares in front...
        NSInteger verticalDoubleMove = row + 2*pow(-1, [self getPlayer]);
        
        if ([self onBoard:board AtColumn:column andRow:verticalDoubleMove]) {
            if ([board isEmptySquareAtColumn:column andRow:verticalDoubleMove]) {
                [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:verticalDoubleMove]];
            }
        }
        
    }
    
    NSInteger verticalMove = row + pow(-1, [self getPlayer]);
    
    // Variables for attacking other pieces...will use eventually
//    NSInteger leftMove = column - 1 > 0 ? column - 1 : column;
//    NSInteger rightMove = column + 1 < [board columns] ? column + 1 : column;
 

    
    if ([self onBoard:board AtColumn:column andRow:verticalMove]) {
        [highlighting addObject:[[DDHTuple alloc] initWithX:column andY:verticalMove]];
    }
    
    // Check if the pawn can attack an enemy?
//    if (![_board objectAtColumn:rightMove andRow:verticalMove] == ) {
//        <#statements#>
//    }
 
    return highlighting;
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

- (NSString*) description
{
    if ([self getPlayer] == ChessPlayerBlack)
        return @"BlackPawn";
    return @"WhitePawn";
}

@end
