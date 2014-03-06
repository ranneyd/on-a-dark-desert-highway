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

// Create 2D array with a certain number of columns and rows, initially filled with a set object.
-(id)initWithColumns:(NSUInteger)columns andRow:(NSUInteger)rows andObject:(id)object;

-(int) count;

// Get the object at a particular location in the 2D array
-(id)objectAtColumn:(NSUInteger)column andRow:(NSUInteger)row;

// Replace the object at one location in the 2D array with another object
-(void) replaceObjectAtColumn:(NSUInteger)column andRow:(NSUInteger)row withObject:(id)object;

@end
