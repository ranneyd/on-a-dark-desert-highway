//
//  DDHRandomSquare.h
//  Chess?
//
//  Created by Dustin Kane on 4/16/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RandomSquare.h"
#import "DDHBoard.h"

@class DDHBoard;

@interface DDHRandomSquare : NSObject <UIAlertViewDelegate>

@property RandomSquare type;
@property DDHBoard *board;
@property NSUInteger x;
@property NSUInteger y;

-(id) initWithColumn:(NSUInteger) column andRow:(NSUInteger) row andBoard:(DDHBoard *) board;

-(id) initNull;

-(void) trigger;


@end
