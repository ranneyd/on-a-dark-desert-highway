//
//  DDHBoard.m
//  Chess
//
//  Created by Dustin Kane on 2/13/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDHBoard.h"

@implementation DDHBoard

+(id)newBoardOfWidth:(int)width andHeight:(int)height
{
    id newBoard = [[self alloc] init];
    [newBoard setBoardWidth:width];
    [newBoard setBoardHeight:height];
    return newBoard;
}


@end
