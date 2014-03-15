//
//  DDH2DArray.m
//  DDHChess
//
//  Created by Dustin Kane on 2/27/14. Updated by Will Clausen and Zakkai Davidon on 3/2/14
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDH2DArray.h"

@implementation DDH2DArray
{
    // The 2D array is implemented as a single NSMutablbeArray
    NSMutableArray* _array;
}

// Create 2D array with a certain number of columns and rows, initially filled with a set object.
-(id)initWithColumns:(NSUInteger)columns andRow:(NSUInteger)rows andObject:(id)object
{
    self.columns = columns;
    self.rows = rows;
    _array = [[NSMutableArray alloc] initWithCapacity:columns*rows];
    for (int i = 0; i < columns*rows; i++)
    {
        [_array addObject:object];
    }
    return self;
}

-(id) objectAtIndex:(NSUInteger)index
{
    return [_array objectAtIndex:index];
}

// Get the object at a particular location in the 2D array
-(id)objectAtColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    // Do some clever array indexing to get the proper object.
    return [_array objectAtIndex:[self rows]*row + column];
}

// Replace the object at one location in the 2D array with another object
-(void)replaceObjectAtColumn:(NSUInteger)column andRow:(NSUInteger)row withObject:(id) object
{
    [_array replaceObjectAtIndex:[self rows]*row + column withObject:object];
}

@end
