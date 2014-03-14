//
//  DDHKnight.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHKnight.h"

@implementation DDHKnight

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*)board andCheck:(BOOL) check
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    NSMutableArray* points = [[NSMutableArray alloc] initWithCapacity:8];
    
    // left 2 up 1
    [points addObject:[[DDHTuple alloc] initWithX:-2 andY:-1]];
    // left 1 up 2
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:-2]];
    // right 1 up 2
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:-2]];
    // right 2 up 1
    [points addObject:[[DDHTuple alloc] initWithX:2 andY:-1]];
    // right 2 down 1
    [points addObject:[[DDHTuple alloc] initWithX:2 andY:1]];
    // right 1 down 2
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:2]];
    // left 1 down 2
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:2]];
    // left 2 down 1
    [points addObject:[[DDHTuple alloc] initWithX:-2 andY:1]];
    
    //NSLog(@"HALP: %d and: %d", [move x], [move y]);
    

    NSMutableArray *highlighting = [[NSMutableArray alloc]init];
    
    // Iterate over moves. If on the board, go there. Knights don't have any other criteria for movement.
    for(int i = 0; i < 8; i++){
        DDHTuple* nextMove = points[i];
        int dx = x + [nextMove x];
        int dy = y + [nextMove y];
        //NSLog(@"Is this working: %d and: %d", [nextMove x], [nextMove y]);
        if([self onBoard:board AtColumn:dx andRow:dy])
            //NSLog(@"Adding move for dx: %d and dy: %d", dx, dy);
            [highlighting addObject:[[DDHTuple alloc] initWithX:dx andY:dy]];
    }
    return highlighting;
}

-(NSString*) description
{
    if ([super getPlayer] == ChessPlayerBlack)
        return @"BlackKnight";
    return @"WhiteKnight";
}
@end
