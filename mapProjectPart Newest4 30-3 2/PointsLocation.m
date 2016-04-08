//
//  PointsLocation.m
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/22/15.
//  Copyright (c) 2015 Tim and Robert. All rights reserved.
//

#import "PointsLocation.h"
#import "mapViewController.h"
#import "ViewController.h"

@implementation PointsLocation



-(BOOL) isTheSameLocation:(PointsLocation *)nextSchool
{
    
    if([nextSchool.pointSchoolName isEqualToString: _pointSchoolName] && [nextSchool.pointSchoolAddress isEqualToString: _pointSchoolAddress])
    {

        return true;
    }
    else
    return false;
}


-(double) distanceBetweenTwoPoints:(PointsLocation *) yourLocation{
    
    static const double DEG_TO_RAD = 0.017453292519943295769236907684886;
    static const double EARTH_RADIUS_IN_METERS = 6372797.560856;
    
    double latitudeArc  = (yourLocation.latitude - _latitude) * DEG_TO_RAD;
    double longitudeArc = (yourLocation.longitude - _longitude) * DEG_TO_RAD;
    double latitudeH = sin(latitudeArc * 0.5);
    latitudeH *= latitudeH;
    double lontitudeH = sin(longitudeArc * 0.5);
    lontitudeH *= lontitudeH;
    double tmp = cos(yourLocation.latitude*DEG_TO_RAD) * cos(_latitude*DEG_TO_RAD);
    double distance = EARTH_RADIUS_IN_METERS * 2.0 * asin(sqrt(latitudeH + tmp*lontitudeH));
    
    double miles= distance/1609.344;
    //NSString *strTest = [NSString stringWithFormat:@"%f", miles];
    
    //return strTest;
    return miles;
}

@synthesize latitude=_latitude;
@synthesize longitude=_longitude;



//Setters for the variables w/ error checking.
-(void) setLatitude:(double)latitude{
    if (latitude<=90.0 && latitude >= -90.0) {
        _latitude=latitude;
    }
    else
        _latitude=0.0;
}

-(void) setLongitude:(double)longitude{
    if (longitude<=180.0 && longitude >= -180.0) {
        _longitude=longitude;
    }
    else
        _longitude=0.0;
}


//Getters for the variables
-(double) latitude{
    return _latitude;
}

-(double) longitude{
    return _longitude;
}

    
@end
