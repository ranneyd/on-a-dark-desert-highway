//
//  RandomSquare.h
//  Chess?
//
//  Created by Dustin Kane on 4/16/14.
//  Copyright (c) 2014 Dark Desert Highway Software. All rights reserved.
//


//Include guards from the tutorial. Assume they are important
#ifndef Chess__RandomSquare_h
#define Chess__RandomSquare_h


// Make our lives easier by defining chess players as ints
typedef NS_ENUM(int, RandomSquare){
    DestroyPlayer = 0,
    TeleportPlayer = 1,
    TeleportEnemy = 2,
    DestroyEnemy = 3,
    FallThrough = 4,
    NullSquare = 5,
    HugeLandmine = 6,
    NewPiece = 7,
    EnemyDoubleAgent = 8,
    PlayerDoubleAgent = 9,
    NumTypes = 10
};

#endif
