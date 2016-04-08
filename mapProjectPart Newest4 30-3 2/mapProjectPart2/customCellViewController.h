//
//  customCellViewController.h
//  mapProjectPart2
//
//  Created by Tim and Robert on 4/19/15.
//  Copyright (c) 2015 Tim and Robert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCellViewController : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *customSchoolLabel;
@property (strong, nonatomic) IBOutlet UILabel *customAddresLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImage;


@end
