//
//  MasterViewController.h
//  Ashmore
//
//  Created by Max Woolf on 14/06/2015.
//  Copyright (c) 2015 Max Woolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstimoteSDK/EstimoteSDK.h"

@interface MasterViewController : UITableViewController <ESTNearableManagerDelegate>

@property ESTNearableManager *nearableManager;

@end

