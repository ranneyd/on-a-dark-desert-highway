//
//  DDHKnight.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHKnight.h"

@implementation DDHKnight

-(NSMutableArray*) highlightMovesWithBoard:(DDH2DArray *)board
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    DDHTuple* points[8];
    
    // left 2 up 1
    [points[0] setX:-2];
    [points[0] setY:-1];
    // left 1 up 2
    [points[1] setX: -1];
    [points[1] setY: -2];
    // right 1 up 2
    [points[2] setX:  1];
    [points[2] setY: -2];
    // right 2 up 1
    [points[3] setX:  2];
    [points[3] setY: -1];
    // right 2 down 1
    [points[4] setX:  2];
    [points[4] setY:  1];
    // right 1 down 2
    [points[5] setX:  1];
    [points[5] setY:  2];
    // left 1 down 2
    [points[6] setX: -1];
    [points[6] setY:  2];
    // left 2 down 1
    [points[7] setX: -2];
    [points[7] setY:  1];
    

    NSMutableArray *highlighting = [[NSMutableArray alloc]init];
    
    // Iterate over moves. If on the board, go there. Knights don't have any other criteria for movement.
    for(int i = 0; i < 8; i++){
        int dx = x + [points[i] x];
        int dy = y + [points[i] y];
        if([self onBoard:board AtColumn:dx andRow:dy])
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
