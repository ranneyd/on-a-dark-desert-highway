//
//  DDH2DArray.h
//  DDHChess
//
//  Created by Dustin Kane on 2/27/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDH2DArray : NSObject

@property NSUInteger rows;

@property NSUInteger columns;

-(id)initWithColumns:(NSUInteger) columns andRow:(NSUInteger) rows;

-(id)objectAtColumn:(NSUInteger) column andRow:(NSUInteger) row;

-(void) replaceObjectAtColumn:(NSUInteger) column andRow:(NSUInteger) row withObject:(id) object;

@end
