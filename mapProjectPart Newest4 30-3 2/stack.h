//
//  stack.h
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/30/15.
//  Copyright (c) Tim and Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stack : NSObject
{
    NSMutableArray *myArray;
}

-(void)push:(id)object;
-(id)pop;
-(id)peek;
-(void)clear;
-(bool)isEmpty;
-(void)print;

@property(readonly)NSInteger count;


@end
