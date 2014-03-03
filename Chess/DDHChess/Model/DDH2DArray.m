//
//  DDH2DArray.m
//  DDHChess
//
//  Created by Dustin Kane on 2/27/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDH2DArray.h"

@implementation DDH2DArray
{
    NSMutableArray* _array;
}

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

-(id)objectAtColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    return [_array objectAtIndex:[self rows]*row + column];
}



-(void)replaceObjectAtColumn:(NSUInteger)column andRow:(NSUInteger)row withObject:(id) object
{
    [_array replaceObjectAtIndex:[self rows]*row + column withObject:object];
}

@end
