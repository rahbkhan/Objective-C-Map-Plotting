//
//  stack.m
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/30/15.
//  Copyright (c) 2015 Tim and Robert. All rights reserved.
//

#import "stack.h"
#import "PointsLocation.h"

@implementation stack

@synthesize count;

-(id)init {
    count = 0;
    myArray = [[NSMutableArray alloc] init];
    return self;
}


- (void)push:(id)object {
    [myArray addObject: object];
    count = myArray.count;
    
}

- (id)pop {
    id obj = nil;
    if([myArray count] > 0)
    {
        obj = [myArray objectAtIndex:(count - 1)];
        [myArray removeObjectAtIndex:(count - 1)];
        count = count - 1;
    }
    return obj;
}

- (id)peek {
    id obj = nil;
    if([myArray count] > 0)
    {
        obj = [myArray objectAtIndex:(count - 1)];
    }
    return obj;
}
- (void)clear {
    [myArray removeAllObjects];
    count = 0;
}

-(bool)isEmpty {
    if(count == 0)
        return true;
    else
        return false;
}

-(void)print {
    PointsLocation *temp = [[PointsLocation alloc] init];
    for(int i = 0; i < count; i++)
    {
        temp = [myArray objectAtIndex:i];
        NSLog(@"%@", temp.pointSchoolName);
    }
}

@end
