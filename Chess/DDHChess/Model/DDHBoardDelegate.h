//
//  DDHBoardDelegate.h
//  DDHChess
//
//  Created by Dustin Kane on 2/18/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellState.h"

@protocol DDHBoardDelegate <NSObject>

-(void)cellStateChanged: (BoardCellState)state forColumn:(int)column addRow:(int) row;

@end
