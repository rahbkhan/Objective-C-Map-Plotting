//
//  mapViewController.h
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/19/15.
//  Copyright (c) 2015 Tim and Robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface mapViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@property (weak, nonatomic) IBOutlet MKMapView *locationMap;

@property (strong, nonatomic) NSString *long1;
@property (strong, nonatomic) NSString *lat1;
@property (strong, nonatomic) NSString *long2;
@property (strong, nonatomic) NSString *lat2;
- (IBAction)streetRoute:(id)sender;



@property NSString *schoolName;
@property NSString *schoolAddress;

@property NSString *schoolName2;
@property NSString *schoolAddress2;

@property (strong, nonatomic) NSMutableArray *universityMV;

@property(weak, nonatomic) MKPolyline *routeLine;
@property (nonatomic, retain) MKPolylineRenderer* routeLineView;

@property (strong, nonatomic) NSMutableArray *Visited;
@property (strong, nonatomic) NSMutableArray *Pred;

-(void)DFS;
@end
