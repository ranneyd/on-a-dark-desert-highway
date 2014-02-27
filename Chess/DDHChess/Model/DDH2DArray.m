//
//  DDH2DArray.m
//  DDHChess
//
//  Created by Dustin Kane on 2/27/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//

#import "DDH2DArray.h"

@implementation DDH2DArray

-(id)initWithColumns:(NSUInteger)columns andRow:(NSUInteger)rows
{
    self.columns = columns;
    self.rows = rows;
    return [super initWithCapacity:columns*rows];
}

-(id)objectAtColumn:(NSUInteger)column andRow:(NSUInteger)row
{
    return [super objectAtIndex:[self rows]*row + column];
}

-(void)replaceObjectAtColumn:(NSUInteger)column andRow:(NSUInteger)row withObject:(id) object
{
    return [super replaceObjectAtIndex:[self rows]*row + column withObject:object];
}

@end
