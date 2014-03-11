//
//  DDHKing.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHKing.h"
#import "DDHBoard.h"

@implementation DDHKing

-(NSMutableArray*) highlightMovesWithBoard:(DDHBoard*) board;
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store move types in here.
    NSMutableArray* points = [[NSMutableArray alloc] initWithCapacity:8];
    
    // up
    [points addObject:[[DDHTuple alloc] initWithX:0 andY:-1]];
    
    // down
    [points addObject:[[DDHTuple alloc] initWithX:0 andY:1]];
    
    // left
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:0]];
    
    // right
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:0]];
    
    // up 1 left 1
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:-1]];
    
    // down 1 left 1
    [points addObject:[[DDHTuple alloc] initWithX:-1 andY:1]];
    
    // up 1 right 1
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:-1]];
    
    // down 1 right 1
    [points addObject:[[DDHTuple alloc] initWithX:1 andY:1]];
    
    NSMutableArray *highlighting = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < 8; i++){
        DDHTuple* nextMove = [points objectAtIndex:i];
        int dx = x + [nextMove x];
        int dy = y + [nextMove y];
        if([self onBoard:board AtColumn:dx andRow:dy]) {
            if ([board doesPieceAtColumn:dx andRow:dy notBelongToPlayer:[self getPlayer]]) {
                /*if([board checkIfMoveFromColumn:x andRow:y toColumn:dx andRow:dy]){
                    NSLog(@"Can't do that!");
                }
                else{
                    NSLog(@"Excuse me, I'm a rep from the King and he can totes go there");
                }*/
                [highlighting addObject:[[DDHTuple alloc] initWithX:dx andY:dy]];
            }
        }
    }
    return highlighting;
}

-(NSString*) description
{
    if ([super getPlayer] == ChessPlayerBlack)
        return @"BlackKing";
    return @"WhiteKing";
}

@end
