//
//  ViewController.m
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/19/15.
//  Copyright (c) 2015 Tim and Robert. All rights reserved.
//

#import "ViewController.h"
#import "mapViewController.h"
#import "customCellViewController.h"
#import "PointsLocation.h"
#import "stack.h"

NSInteger howManySelection=0;
NSString *latitude1;
NSString *longitude1;
NSString *latitude2;
NSString *longitude2;
NSString *format = @ ".gif";
NSString *newFormat;
NSString *state;

NSString *sName;
NSString *sAddress;
NSString *sName2;
NSString *sAddress2;

@interface ViewController () {
    PointsLocation *myLocation;
    PointsLocation *yourLocation;
    
}

@end


@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CollegeAddressesWithLatAndLon" ofType:@"txt"];
    
    NSString *fileAsAString = [[NSString alloc] initWithContentsOfFile:path encoding:NSASCIIStringEncoding error:NULL];
    NSArray *fileAsAArray = [fileAsAString componentsSeparatedByString:@"\n"];
   
    _university = [[NSMutableArray alloc] init];
    
    PointsLocation *tempUniversity;
    double tempLat;
    double tempLong;
    
    for(int index = 0; index < [fileAsAArray count]; index++)
    {
       
        //tempUniversity = NULL;
        NSString *line = [fileAsAArray objectAtIndex: index];
        if([line containsString:@"lat"] && [line containsString:@":"])	 {
            NSInteger lineLength = [line length];
            lineLength = lineLength - 7;
            NSRange range = NSMakeRange(6, lineLength);
            
            tempLat = [[line substringWithRange: range] doubleValue];
            tempUniversity.latitude = tempLat;
            
        }
        else if([line containsString:@"lng"] && [line containsString:@":"]) {
            
            tempLong = [[line substringFromIndex:6] doubleValue];
            tempUniversity.longitude = tempLong;
            
            [_university addObject:tempUniversity];
        }
        else if([line containsString:@","]) {
            
            tempUniversity.pointSchoolAddress = line;
            
            NSInteger addressLineLen = [line length];
            addressLineLen = addressLineLen - 8;
            NSRange stateRange = NSMakeRange(addressLineLen, 2);
            tempUniversity.pointState = [line substringWithRange:stateRange];
        }
        else if([line containsString:@" "]){
            tempUniversity = [[PointsLocation alloc] init];
            tempUniversity.pointSchoolName = line;
        }
        
    }
    _stateAbv = [[NSMutableArray alloc] initWithCapacity:[fileAsAString length]];
   
    /*
    //Mutable Array for Visited populated with "false" in the entire array.
    _Visited = [[NSMutableArray alloc] init];
    {
        for( int i =0; i< [_university count]; i++)
        {
            _Visited[i]= @"false";
            //NSLog(@"%@", _Visited[i]);
        }
    }
    
    //Mutable Array for Pred with "NULL" assigned to the entire array.
    _Pred = [[NSMutableArray alloc] init];
    {
        for( int i =0; i< [_university count]; i++)
        {
            _Pred[i]= @"NULL";
            //NSLog(@"%@", _Pred[i]);
        }
    }
    */
    
    PointsLocation *tempAddress = [[PointsLocation alloc] init];
    for(int i = 0; i < [_university count]; i++)
    {
        tempAddress = [_university objectAtIndex:i];
        //NSString *addressLine = [_addressArray objectAtIndex: i];
        NSString *addressLine = tempAddress.pointSchoolAddress;
        
        NSInteger addressLineLen = [addressLine length];
        addressLineLen = addressLineLen - 8;
        NSRange stateRange = NSMakeRange(addressLineLen, 2);
        _stateAbv[i] = [addressLine substringWithRange:stateRange];
    }
    
    /*
    for(int test = 0; test < 5; test++) {
        [self push:[_university objectAtIndex: test]];
    }
    */
 
    NSUInteger uCount = [_university count];
    for (NSUInteger i = 0; i < uCount; ++i) {
        NSInteger remainingCount = uCount - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [_university exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return [_addressArray count];
    return [_university count];
    
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    NSUInteger count = [_university count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [_university exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    */
    static NSString * cellIdentifier = @"customCell";
    PointsLocation *tempCell = [[PointsLocation alloc] init];
    
    customCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil) {
        cell = [[customCellViewController alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
     if (indexPath.section==0) {
         tempCell = [_university objectAtIndex:indexPath.row];
    //    cell.customSchoolLabel.text = [_schoolArray objectAtIndex:indexPath.row];
    //    cell.customAddresLabel.text = [_addressArray objectAtIndex:indexPath.row];
         cell.customSchoolLabel.text = tempCell.pointSchoolName;
         cell.customAddresLabel.text = tempCell.pointSchoolAddress;
         
         state = [_stateAbv objectAtIndex:indexPath.row];
         newFormat= [tempCell.pointState stringByAppendingString:format];
         
         
         //if([newFormat  isEqual: newFormat])
        cell.stateImage.image = [UIImage imageNamed:newFormat];
        
    }
    else
    {
        tempCell = [_university objectAtIndex:indexPath.row];
        
        cell.customSchoolLabel.text = tempCell.pointSchoolName;
        cell.customAddresLabel.text = tempCell.pointSchoolAddress;
        
        //cell.customSchoolLabel.text = [_schoolArray objectAtIndex:indexPath.row];
        //cell.customAddresLabel.text = [_addressArray objectAtIndex:indexPath.row];
    }
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    PointsLocation *tempSelected = [[PointsLocation alloc] init];
    NSString *tempLat;
    NSString *tempLong;
    
    yourLocation = [[PointsLocation alloc] init];
    myLocation = [[PointsLocation alloc] init];
    if(howManySelection==0)
    {
        tempSelected = [_university objectAtIndex:indexPath.row];
        
        tempLat = [NSString stringWithFormat:@"%f", tempSelected.latitude];
        latitude1 = tempLat;
        tempLong = [NSString stringWithFormat:@"%f", tempSelected.longitude];
        longitude1= tempLong;
        
        sName= tempSelected.pointSchoolName;
        sAddress= tempSelected.pointSchoolAddress;
        
        //latitude1= [_latitudeArray objectAtIndex:indexPath.row];
        //longitude1=[_longitudeArray objectAtIndex:indexPath.row];
        
        //sName= [_schoolArray objectAtIndex:indexPath.row];
        //sAddress=[_addressArray objectAtIndex:indexPath.row];
        
        //NSLog(@"lat %@", latitude1);
        //NSLog(@"long %@", longitude1);
        howManySelection++;
        //NSLog(@"selection = %ld", howManySelection);
        

    }
    else if(howManySelection==1)
    {
        tempSelected = [_university objectAtIndex:indexPath.row];
        
        tempLat = [NSString stringWithFormat:@"%f", tempSelected.latitude];
        latitude2 = tempLat;
        tempLong = [NSString stringWithFormat:@"%f", tempSelected.longitude];
        longitude2 = tempLong;
        
        sName2 = tempSelected.pointSchoolName;
        sAddress2 = tempSelected.pointSchoolAddress;
        
        /*
        longitude2= [_longitudeArray objectAtIndex:indexPath.row];
        latitude2= [_latitudeArray objectAtIndex:indexPath.row];
        
        sName2= [_schoolArray objectAtIndex:indexPath.row];
        sAddress2=[_addressArray objectAtIndex:indexPath.row];
         */
        //NSLog(@"lat %@", latitude2);
        //NSLog(@"long %@", longitude2);
        howManySelection++;
        myLocation.pointSchoolName = sName;
        myLocation.pointSchoolAddress = sAddress;
        
        yourLocation.pointSchoolName = sName2;
        yourLocation.pointSchoolAddress = sAddress2;
    
        if([myLocation isTheSameLocation:yourLocation] == true)
        {
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"ALERT!!!"
                                                        message:@"Please Do Not Choose the Same Selection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [mes show];
        }
        else if([myLocation isTheSameLocation:yourLocation] == false)
        {
            [self performSegueWithIdentifier:@"mySegue" sender:self];
            //[myLocation DFS:yourLocation];
        }
                howManySelection = 0;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    mapViewController *mvc = [segue destinationViewController];
    
    //Assigns the inputted data to the variables from the MapViewController.h
    mvc.lat1 = latitude1;
    mvc.long1 = longitude1;
    mvc.lat2 = latitude2;
    mvc.long2 =longitude2;
    
    mvc.schoolName=sName;
    mvc.schoolAddress=sAddress;
    mvc.schoolName2=sName2;
    mvc.schoolAddress2=sAddress2;
    
    /*
    mvc.schoolArrayMV = _schoolArray;
    mvc.addressArrayMV = _addressArray;
    mvc.latArrayMV = _latitudeArray;
    mvc.lngArrayMV = _longitudeArray;
    */
    
    mvc.universityMV = _university;
   
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}

@end

