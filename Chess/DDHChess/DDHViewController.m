//
//  DDHViewController.m - Implementation of main game view controller
//  DDHChess
//
//  Created by Colin Eberhardt and modified by Dustin Kane, Will Clausen and Zakkai Davidson on 2/15/14.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHViewController.h"
#import "DDHRandomChessController.h"
#import <QuartzCore/QuartzCore.h>

@interface DDHViewController()
@property (weak, nonatomic) IBOutlet UIButton *randomChessButton;
@property (weak, nonatomic) IBOutlet UIButton *boringChessButton;

@end

@implementation DDHViewController
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _randomChessButton.layer.cornerRadius = 20;
    _randomChessButton.layer.masksToBounds = YES;
    
    _boringChessButton.layer.cornerRadius = 5;
    _boringChessButton.layer.masksToBounds = YES;
    
    
    for (int i = 0; i < 10; i++){
        UIImageView *queen = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WhiteQueen.png"]];
        [queen setAlpha:0.8];
        [self.view addSubview:queen];
        [self.view sendSubviewToBack:queen];
        
        int x = [self setPieceRandomTop:queen];
        CGRect rect = [queen frame];
        [queen setFrame:CGRectMake(rect.origin.x, arc4random()%((int)self.view.frame.size.height+100) - 50 , rect.size.width, rect.size.height)];
        
        [self fallPiece:queen atX:x];
}
    
    
    
}

-(void) fallPiece:(UIImageView*) piece atX:(int) x{
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView commitAnimations];
    
    double distance = self.view.frame.size.height +100 - [piece frame].origin.y;
    double speed = 200;
    [UIView animateWithDuration: distance/speed animations:^{
        [piece setFrame:CGRectMake(x, self.view.frame.size.height + 100, 100, 100)];
    } completion:^(BOOL finished){
        [self fallPiece:piece atX:[self setPieceRandomTop:piece]];
    }];
}
-(int) setPieceRandomTop:(UIImageView*) piece
{
    int x = arc4random()%((int)self.view.frame.size.width + 98) -99;
    [piece setFrame:CGRectMake(x, -99, 100, 100)];
    return x;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)randomChessAction:(id)sender
{
    DDHRandomChessController *controller = [[DDHRandomChessController alloc] initWithNibName:nil bundle:nil andRandom:YES];
    
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)boringChessAction:(id)sender
{
    DDHRandomChessController *controller = [[DDHRandomChessController alloc] initWithNibName:nil bundle:nil andRandom:NO];
    
    [self presentViewController:controller animated:NO completion:nil];
}

@end
