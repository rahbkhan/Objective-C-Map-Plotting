//
//  ViewController.h
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/19/15.
//  Copyright (c) 2015 Tim and Robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointsLocation.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{

}


@property (weak, nonatomic) IBOutlet UITableView *myTable;


/*
@property (strong, nonatomic) NSMutableArray *latitudeArray;
@property (strong, nonatomic) NSMutableArray *longitudeArray;
@property (strong, nonatomic) NSMutableArray *addressArray;
@property (nonatomic, retain) NSMutableArray *schoolArray;
*/
@property (strong, nonatomic) NSMutableArray *stateAbv;

@property (strong, nonatomic) NSMutableArray *university;

//@property (strong, nonatomic) NSMutableArray *Visited;
//@property (strong, nonatomic) NSMutableArray *Pred;


@end

