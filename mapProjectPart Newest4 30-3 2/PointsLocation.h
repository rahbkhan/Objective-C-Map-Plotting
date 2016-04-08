//
//  PointsLocation.h
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/22/15.
//  Copyright (c) 2015 Tim and Robert. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PointsLocation : NSObject

//Lat and Long for first location
@property double latitude;
@property double longitude;


@property NSString *pointSchoolName;
@property NSString *pointSchoolAddress;
@property NSString *pointState;

-(double) distanceBetweenTwoPoints:(PointsLocation *) yourLocation;

-(BOOL) isTheSameLocation:(PointsLocation *) nextSchool;


@end
