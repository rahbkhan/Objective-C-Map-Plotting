//
//  mapViewController.m
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/19/15.
//  Copyright (c) 2015 Tim and Robert. All rights reserved.
//

#import "mapViewController.h"
#include <math.h>
#include "PointsLocation.h"
#include "stack.h"

NSString *strTest;
NSString *comma= @",";
NSString *MyLatLong;
NSString *Destination;
@interface mapViewController ()
{
    //NSInteger numberOfElementsInArray;
    PointsLocation *firstSchool;
    PointsLocation *finalSchool;
    stack *route;
    
}
@end

@implementation mapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //Changes the from a string to a double to put the
    //points on a map
    
    //Mutable Array for Visited populated with "false" in the entire array.
    _Visited = [[NSMutableArray alloc] init];
    {
        for( int i =0; i< [_universityMV count]; i++)
        {
            _Visited[i]= @"false";
            //NSLog(@"%@", _Visited[i]);
        }
    }
    
    //Mutable Array for Pred with "NULL" assigned to the entire array.
    _Pred = [[NSMutableArray alloc] init];
    {
        for( int i =0; i< [_universityMV count]; i++)
        {
            _Pred[i]= @"NULL";
            //NSLog(@"%@", _Pred[i]);
        }
    }
    
    /*
    stack *test = [[stack alloc] init];
    for(int i = 0; i < 5; i++) {
        [test push:_universityMV[i]];
    }
    */
    
    //[test print];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"mascot-Cameron-UniversityW.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    double finalLat1 = [_lat1 doubleValue];
    double finalLong1 = [_long1 doubleValue ];
    double finalLat2 = [_lat2 doubleValue];
    double finalLong2 = [_long2 doubleValue];
    
    firstSchool = [[PointsLocation alloc] init];
    firstSchool.latitude =finalLat1;
    firstSchool.longitude=finalLong1;
    firstSchool.pointSchoolName = _schoolName;
    firstSchool.pointSchoolAddress = _schoolAddress;
    
    finalSchool = [[PointsLocation alloc] init];
    finalSchool.latitude = finalLat2;
    finalSchool.longitude= finalLong2;
    finalSchool.pointSchoolName = _schoolName2;
    finalSchool.pointSchoolAddress = _schoolAddress2;

    //[myLocation isTheSameLocation:yourLocation];
    
    double distance=[firstSchool distanceBetweenTwoPoints:finalSchool];
    
    [self DFS];
    [route print];
    /*
    myLocation.schools = schoolArrayMV;
    myLocation.address = _addressArrayMV;
    myLocation.lat = _latArrayMV;
    myLocation.lng = _lngArrayMV;
    
    [myLocation DFS:yourLocation];
    */
    
    
    //The first location on the map
    CLLocationCoordinate2D location1;
    location1.latitude = firstSchool.latitude;
    location1.longitude = firstSchool.longitude;
    
    
    MKPointAnnotation *location1Point = [[MKPointAnnotation alloc] init];
    location1Point.coordinate = location1;
    location1Point.title = _schoolName;
    location1Point.subtitle = _schoolAddress;
    [self.locationMap addAnnotation: location1Point];
    
    //The second location on the map
    CLLocationCoordinate2D location2;
    location2.latitude = finalSchool.latitude;
    location2.longitude = finalSchool.longitude;
    
    MKPointAnnotation *location2Point = [[MKPointAnnotation alloc] init];
    location2Point.coordinate = location2;
    location2Point.title = _schoolName2;
    location2Point.subtitle = _schoolAddress2;
    [self.locationMap addAnnotation: location2Point];
    
    _lblResult.text = [NSString stringWithFormat:@"%f", distance];
   
    
    
    //following array will store the information about the universities along the  path. CLLocationCoordinate2D is a structure, so we must use malloc to specify the amount of memory
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc (sizeof(CLLocationCoordinate2D));
    
    //use a for loop, if the path is stored in an array
    /*
    CLLocation *location0 = [[CLLocation alloc] initWithLatitude:firstSchool.latitude longitude:firstSchool.longitude];
    coordinateArray[0] = location0.coordinate;
    
    
    CLLocation *locationTest = [[CLLocation alloc] initWithLatitude: finalSchool.latitude longitude:finalSchool.longitude];
    coordinateArray[1] = locationTest.coordinate;
    */
    
    NSInteger count = 1;
    CLLocation *location0 = [[CLLocation alloc] initWithLatitude:firstSchool.latitude longitude:firstSchool.longitude];
    coordinateArray[0] = location0.coordinate;
    while ([route isEmpty] == false) {
    PointsLocation *current = [[PointsLocation alloc] init];
    for(int test = 0; test < [_universityMV count]; test++) {
        current = [route pop];
        if([[_Visited objectAtIndex: test]  isEqual: @"true"] && [current isTheSameLocation:[_Pred objectAtIndex:test]] == true) {
           CLLocation *locationTest = [[CLLocation alloc] initWithLatitude: current.latitude longitude:current.longitude];
            coordinateArray[count] = locationTest.coordinate;
            
            CLLocationCoordinate2D location;
            location.latitude = current.latitude;
            location.longitude = current.longitude;
            
            MKPointAnnotation *locationTestPoint = [[MKPointAnnotation alloc] init];
            locationTestPoint.coordinate = location;
            locationTestPoint.title = current.pointSchoolName;
            locationTestPoint.subtitle = current.pointSchoolAddress;
            [self.locationMap addAnnotation: locationTestPoint];
            count++;
        }
    }
    }
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinateArray count: count];
    _routeLine = polyline;
    _routeLineView = [[MKPolylineRenderer alloc] initWithPolyline:_routeLine];
    _routeLineView.strokeColor = [UIColor redColor];
    _routeLineView.lineWidth = 5;
    [_locationMap addOverlay:polyline];

}

- (MKPolylineRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    return _routeLineView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)DFS
{
    route = [[stack alloc] init];
    PointsLocation *current = [[PointsLocation alloc] init];
    current = NULL;
    NSInteger X = 0;
    [route push:firstSchool];
    
    while([route isEmpty] == false)
    {
        current = [route pop];
        //NSLog(@"%@", current.pointSchoolName);
        //[route print];
        if([current isTheSameLocation:finalSchool] == true) {
            return;
        }
        else {
            for(X = 0; X < [_universityMV count]; X++){
                double distance = [current distanceBetweenTwoPoints:[_universityMV objectAtIndex:X]];
                if(distance <= 200 && [[_Visited objectAtIndex: X] isEqual: @"false"] && [current isTheSameLocation: [_universityMV objectAtIndex: X]] == false) {
                    _Pred[X] = current;
                    [route push:[_universityMV objectAtIndex: X]];
                    _Visited[X] = @"true";
                    //X++;
                    }
             //   X++;
            }
        }
    }
    //[route print];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)streetRoute:(id)sender {
    NSString *MyLatLong= [NSString stringWithFormat:@"%@%@%@", _lat1, comma , _long1];
    NSString *Destination= [NSString stringWithFormat:@"%@%@%@", _lat2, comma , _long2];
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString:
      [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@&daddr=%@",
       MyLatLong,
       Destination]]];
}
@end
