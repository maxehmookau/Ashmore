//
//  DetailViewController.h
//  Ashmore
//
//  Created by Max Woolf on 14/06/2015.
//  Copyright (c) 2015 Max Woolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

