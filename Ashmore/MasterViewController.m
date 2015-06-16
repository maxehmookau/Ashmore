//
//  MasterViewController.m
//  Ashmore
//
//  Created by Max Woolf on 14/06/2015.
//  Copyright (c) 2015 Max Woolf. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    _nearableManager = [ESTNearableManager new];
    _nearableManager.delegate = self;
    [_nearableManager startMonitoringForType:ESTNearableTypeGeneric];
    [_nearableManager startMonitoringForType:ESTNearableTypeBed];
    
}

- (void)nearableManager:(ESTNearableManager *)manager didEnterTypeRegion:(ESTNearableType)type {
    if(type == ESTNearableTypeGeneric) {
        NSLog(@"Entered generic area");
        [_nearableManager startRangingForType:ESTNearableTypeGeneric];
    }else if (type == ESTNearableTypeBed) {
        NSLog(@"Entered bedroom area");
        [_nearableManager startRangingForType:ESTNearableTypeBed];
    }
}

- (void)nearableManager:(ESTNearableManager *)manager didRangeNearables:(NSArray *)nearables withType:(ESTNearableType)type {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Entered area" message:@"HELLO!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    if (type == ESTNearableTypeBed) {
        notification.alertBody = @"Sleep well Max...";
        notification.soundName = UILocalNotificationDefaultSoundName;
    } else if (type == ESTNearableTypeGeneric) {
        notification.alertBody = @"Don't forget your lunch Max!";
        notification.soundName = UILocalNotificationDefaultSoundName;
    }
    NSLog(@"Ranged lots of nearables %@", nearables);
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    [_nearableManager stopRanging];
}

- (void)nearableManager:(ESTNearableManager *)manager didRangeNearable:(ESTNearable *)nearable {
    NSLog(@"Ranging nearable %@", nearable);
}

- (void)nearableManager:(ESTNearableManager *)manager didExitTypeRegion:(ESTNearableType)type {
    NSLog(@"Left area");
    [_nearableManager stopRanging];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = @"Desk";
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
