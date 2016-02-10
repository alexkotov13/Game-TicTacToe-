//
//  ViewController.m
//  0
//
//  Created by admin on 03.02.16.
//  Copyright (c) 2016 admin. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

int widthLine; // ширина линии
CGSize playAreaSize;
int sizeCell;

int savePlayer;
int player;
enum
{
    player1 = 0,
    player2 = 1
};

NSString *Player1 ;
NSString *Player2 ;

NSMutableArray * _movesPlayersArray;
NSArray *_player;

int numberOfCellsChecked;
int indexXCoord,indexYCoord;
int lineSize ;
CGPoint startPoint;
CGPoint finishPoint;
int indentFromTheEdge;


@interface ViewController ()
{
    UIView *playArea;
    UILabel *fromLabelPlayer;
    UITapGestureRecognizer *tap;
    UIColor *color;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    color = [UIColor alloc];
       
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _player = @[@"player1", @"player2"];
    indentFromTheEdge = 10; // отступ
    indexXCoord = 0;
    indexYCoord = 0;
    numberOfCellsChecked = 3;
    widthLine = 7;    
    playAreaSize = self.view.bounds.size;
    playAreaSize.width -= 2 * indentFromTheEdge;
    playAreaSize.height = playAreaSize.width;
    sizeCell = 0;    

    Player1 = @"player1";
    Player2 = @"player2";
    
    player = 0; 
    startPoint.x = indentFromTheEdge;
    startPoint.y =  playAreaSize.width / 4;
    [self drawLabelNameGame];
    [self drawPlayArea:startPoint];
    
    sizeCell = (playAreaSize.width - 2 * indentFromTheEdge) / numberOfCellsChecked;    
    color = [UIColor blackColor];
    lineSize = widthLine;    
    
    _movesPlayersArray = [NSMutableArray array];
    int j = 0;
    while (j < numberOfCellsChecked)
    {
        NSMutableArray * arrayInArray = [NSMutableArray array];
        int i = 0;
        while (i < numberOfCellsChecked)
        {
            [arrayInArray addObject:@""];
            i++;
        }
        [_movesPlayersArray addObject:arrayInArray];
        j++;
    }

    for(int i = 0; i < numberOfCellsChecked - 1; i++)
    {      
        startPoint.x = sizeCell  * (i + 1) + widthLine * i;
        startPoint.y =  0;
        finishPoint.x = startPoint.x;
        finishPoint.y = playAreaSize.width ;
        [self drawALineFromToPoint:finishPoint FinishPoint:startPoint Color:color LineSize:lineSize];      
               
        startPoint.x = 0;
        startPoint.y = sizeCell  * (i + 1) + widthLine * i;
        finishPoint.x = playAreaSize.width  ;
        finishPoint.y = startPoint.y;
        [self drawALineFromToPoint:finishPoint FinishPoint:startPoint Color:color LineSize:lineSize];      
    }

    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(handleTap:)];
    [playArea addGestureRecognizer:tap]; 
}

-(void)drawLabelNameGame
{
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 100, 50)];
    fromLabel.text = @"Game x/0";
    fromLabel.font =  [UIFont fontWithName:@"ProximaNovaSemibold" size:14];
    fromLabel.numberOfLines = 1;
    fromLabel.textColor = [UIColor blackColor];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLabel];
    
    fromLabelPlayer = [[UILabel alloc]initWithFrame:CGRectMake(120, 5, 200, 50)];
    fromLabelPlayer.text = @"";
    fromLabelPlayer.font =  [UIFont fontWithName:@"ProximaNovaSemibold" size:14];
    fromLabelPlayer.numberOfLines = 1;
    fromLabelPlayer.textColor = [UIColor blackColor];
    fromLabelPlayer.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLabelPlayer];
}
-(void)drawPlayArea:(CGPoint)point
{
    playArea = [[UIView alloc]initWithFrame:CGRectMake(point.x, point.y, playAreaSize.width, playAreaSize.height)]; // игровая область
    [playArea setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:playArea];
}

-(int)getNumberOfFilledCellsInTheHorizontal
{
    int i = -1;
    for(int l = 0; l < numberOfCellsChecked; l++)
    {
        if (_movesPlayersArray[indexXCoord][l] == _player[savePlayer] )
        {
            i++;
        }
    }
    return i;
}

-(int)getNumberOfFilledCellsInTheVertical
{
    int i = -1;
    for(int k = 0; k < numberOfCellsChecked; k++)
    {
        if (_movesPlayersArray[k][indexYCoord] == _player[savePlayer] )
        {
            i++;
        }
    }
    return i;
}

-(int)getNumberOfFilledCellsInTheMainDiagonal
{
    int i = -1;    
    for(int j = 0; j < numberOfCellsChecked; j++)
    {        
        if (_movesPlayersArray[j][j] == _player[savePlayer] )
        {
            i++;
        }        
    }
    return i;
}
-(int)getNumberOfFilledCellsInTheSecondaryDiagonal
{
    int i = -1;    
    for(int j = 0; j < numberOfCellsChecked; j++)
    {        
        if (_movesPlayersArray[j][numberOfCellsChecked - (j + 1)] == _player[savePlayer] )
        {
            i++;
        }
    }
    return i;
}

- (void)handleTap:(UITapGestureRecognizer*)tap1
{
    CGPoint point = [tap1 locationInView:playArea];
    
    color = [UIColor blueColor];
    lineSize = 7;  
    for(int j = 0; j < numberOfCellsChecked; j++)
    {
        if(point.x < playAreaSize.width *(j + 1)/numberOfCellsChecked)
        {
            indexXCoord = j;
            break;
        }
    }
    
    for(int j = 0; j < numberOfCellsChecked; j++)
    {
        if(point.y < playAreaSize.width *(j + 1)/numberOfCellsChecked)
        {
            indexYCoord = j;
            break;
        }
    }    
    startPoint.x = sizeCell * indexXCoord + sizeCell / 4 + widthLine * indexXCoord;
    startPoint.y = sizeCell * indexYCoord + sizeCell / 4 + widthLine * indexYCoord;
    finishPoint.x = sizeCell * indexXCoord + sizeCell - sizeCell / 4 + widthLine * indexXCoord;
    finishPoint.y = sizeCell * indexYCoord + sizeCell - sizeCell / 4 + widthLine * indexYCoord;    
    
    if ([_movesPlayersArray[indexXCoord][indexYCoord] isEqualToString:@""])
    {
        _movesPlayersArray[indexXCoord][indexYCoord] = _player[player];
        if(player == 0)
        {
            fromLabelPlayer.text = Player1;
            
        }
        else
            fromLabelPlayer.text = Player2;
        
        switch (player)
        {
            case player1:
            {
                [self drawALineFromToPoint:finishPoint FinishPoint:startPoint Color:color LineSize:lineSize];
                startPoint.x += sizeCell / 2;
                finishPoint.x -= sizeCell / 2;
                [self drawALineFromToPoint:finishPoint FinishPoint:startPoint Color:color LineSize:lineSize];
                savePlayer = player;
                player++;
            }
                break;
            case player2:
            {
                [self drawACircle:startPoint];
                savePlayer = player;
                player = 0;
            }
                break;                
        }
    }

    lineSize = 3;
    startPoint.x = sizeCell * indexXCoord;
    startPoint.y = sizeCell * indexYCoord;
    finishPoint.x = sizeCell * indexXCoord;
    finishPoint.y = sizeCell * indexYCoord;
    color = [UIColor blackColor];
    if([self getNumberOfFilledCellsInTheVertical] == numberOfCellsChecked-1)
    {
        startPoint.x = 0;
        startPoint.y += sizeCell / 2 + widthLine * indexYCoord;
        finishPoint.x = playAreaSize.width;
        finishPoint.y += sizeCell / 2 + widthLine * indexYCoord;
        [self drawALineFromToPoint:startPoint FinishPoint:finishPoint Color:color LineSize:lineSize];
        [self conclusion];
        [playArea removeGestureRecognizer:tap];
    }
    else if([self getNumberOfFilledCellsInTheHorizontal] == numberOfCellsChecked-1)
    {
        startPoint.x += sizeCell / 2 + widthLine * indexXCoord;
        startPoint.y = 0;
        finishPoint.x += sizeCell / 2 + widthLine * indexXCoord;
        finishPoint.y = playAreaSize.width;
        
        [self drawALineFromToPoint:startPoint FinishPoint:finishPoint Color:color LineSize:lineSize];
        [self conclusion];
        [playArea removeGestureRecognizer:tap];
    }
    else
    {
        if([self getNumberOfFilledCellsInTheMainDiagonal] == numberOfCellsChecked-1)
        {
            startPoint.x = playAreaSize.width - widthLine;
            startPoint.y = playAreaSize.width - widthLine;
            finishPoint.x = widthLine;
            finishPoint.y = widthLine;
            [self drawALineFromToPoint:startPoint FinishPoint:finishPoint Color:color LineSize:lineSize];
            
            [self conclusion];
            [playArea removeGestureRecognizer:tap];
        }
        else if([self getNumberOfFilledCellsInTheSecondaryDiagonal] == numberOfCellsChecked-1)
        {
            startPoint.x = playAreaSize.width - widthLine;
            startPoint.y = widthLine;
            finishPoint.x = widthLine;
            finishPoint.y = playAreaSize.width - widthLine;
           
            [self drawALineFromToPoint:startPoint FinishPoint:finishPoint Color:color LineSize:lineSize];
            [self conclusion];
            [playArea removeGestureRecognizer:tap];
        }
        else
        {
            [self conclusionDraw];
        }
    }
    
}

-(void)conclusion
{
    if(savePlayer == 0)
        fromLabelPlayer.text = @"Player1 won !!!";
    else
        fromLabelPlayer.text = @"Player2 won !!!";
}
-(void)conclusionDraw
{
    for(int i = 0; i < numberOfCellsChecked; i++)
    {
        for(int j = 0; j < numberOfCellsChecked; j++)
        {
            if (![_movesPlayersArray[i][j] isEqualToString:@""])
                if(i == numberOfCellsChecked - 1 && j == numberOfCellsChecked - 1)
                    fromLabelPlayer.text = @"Draw !!!";
        }
    }
}

-(void)drawACircle:(CGPoint)p
{
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(p.x , p.y ,sizeCell / 2, sizeCell / 2)] CGPath]];
    [circleLayer setStrokeColor:[[UIColor redColor] CGColor]];
    [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
    circleLayer.lineWidth = widthLine;
    circleLayer.cornerRadius = sizeCell / 2;
    [[playArea layer] addSublayer:circleLayer];
}

-(void)drawALineFromToPoint:(CGPoint)startPoint FinishPoint:(CGPoint)finishPoint Color:(UIColor*)color1 LineSize:(int)lineSize1
{    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startPoint.x , startPoint.y)];
    [path addLineToPoint:CGPointMake(finishPoint.x , finishPoint.y )];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = color1.CGColor;
    shapeLayer.cornerRadius = 5.0f;
    shapeLayer.lineWidth = lineSize1;    
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [playArea.layer addSublayer:shapeLayer];  
}
@end







