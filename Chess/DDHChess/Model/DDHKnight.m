//
//  DDHKnight.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHKnight.h"

@implementation DDHKnight

-(Tuple*) highlightMovesWithBoard:(DDH2DArray *)board
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    struct Tuple* points[8];
    
    // left 2 up 1
    points[0]->x = -2;
    points[0]->y = -1;
    // left 1 up 2
    points[1]->x = -1;
    points[1]->y = -2;
    // right 1 up 2
    points[2]->x =  1;
    points[2]->y = -2;
    // right 2 up 1
    points[3]->x =  2;
    points[3]->y = -1;
    // right 2 down 1
    points[4]->x =  2;
    points[4]->y =  1;
    // right 1 down 2
    points[5]->x =  1;
    points[5]->y =  2;
    // left 1 down 2
    points[6]->x = -1;
    points[6]->y =  2;
    // left 2 down 1
    points[7]->x = -2;
    points[7]->y =  1;
    

    BOOL** highlighting = [super blankHighlightingForBoard:board];
    
    // Iterate over moves. If on the board, go there. Knights don't have any other criteria for movement.
    for(int i = 0; i < 8; i++){
        int dx = x + points[i]->x ;
        int dy = y + points[i]->y ;
        if([self onBoard:board AtColumn:dx andRow:dy])
            highlighting[dx][dy] = YES;
    }
    return highlighting;
}

@end
