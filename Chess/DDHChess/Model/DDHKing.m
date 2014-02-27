//
//  DDHKing.m
//  DDHChess
//
//  Created by Dustin Kane on 2/21/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHKing.h"

@implementation DDHKing

-(DDHTuple*) highlightMovesWithBoard:(DDH2DArray *) board;
{
    NSUInteger x = [self x];
    NSUInteger y = [self y];
    
    // Store moves in here.
    DDHTuple* points[8];
    
    // up
    [points[0] setX: 0];
    [points[0] setY: -1;
    // up right
    [points[1] setX:  1];
    [points[1] setY: -1;
    // right
    [points[2] setX:  1];
    [points[2] setY:  0;
    // down right
    [points[3] setX:  1];
    [points[3] setY:  1;
    // down
    [points[4] setX:  0];
    [points[4] setY:  1;
    // down left
    [points[5] setX: -1];
    [points[5] setY:  1;
    // left
    [points[6] setX: -1];
    [points[6] setY:  0;
    // up left
    [points[7] setX: -1];
    [points[7] setY: -1;
    
    BOOL** highlighting = [super blankHighlightingForBoard:board];
    
    for(int i = 0; i < 8; i++){
        int dx = x + [points[i]->x ;
        int dy = y + [points[i]->y ;
        if([self onBoard:board AtColumn:dx andRow:dy])
            highlighting[dx][dy] = YES;
    }
    return highlighting;
}

@end
