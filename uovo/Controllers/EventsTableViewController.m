//
//  EventsTableViewController.m
//  uovo
//
//  Created by George Nishimura on 08/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import "EventsTableViewController.h"

static NSString *const kKeychainItemName = @"Google Calendar API";
static NSString *const kClientID = @"743064933737-gie4sbh4krr083r488rk8n8hi58osk3f.apps.googleusercontent.com";
static NSString *const kClientSecret = @"8jWuUBjxczqKE2EzFG6vEl8a";



@interface EventsTableViewController ()

@end

@implementation EventsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationItem setTitle:@"Today"];
    
    self.events = [NSArray array];
    [self.tableView registerClass:[EventCell class] forCellReuseIdentifier:@"EventCell"];
    [self fetchEvents];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events delegate methods

- (void)fetchEvents {
            [UovoService getEventsForDate:[NSDate date] WithHandler:^(NSError *error, NSArray *events) {
                if(error == nil){
                    self.events = events;
                    [self.tableView reloadData];
                }
            }];
}

-(void)checkIn:(Event *)event andBlock:(void(^)(Event *event)) block {
    
//    Event * event;
//    NSInteger index;
//    
//    for(int i = 0; i < self.events.count; i++){
//        Event * ev = [self.events objectAtIndex:i];
//        if(ev.eventId == event.eventId) {
//            event = ev;
//            index = i;
//            break;
//        }
//    }
    
    [UovoService checkInForEvent:event.eventId withRequestHandler:^(NSError *error, NSDate* checkInTime) {
        
        event.checkInTime = checkInTime;
        block(event);
        [event saveEvent];
        
        [self.tableView reloadData];
//        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    } andCompletionHandler:^(NSError *error, NSDate* checkInTime) {
        if(error == nil){
            NSLog(@"Check In Request Returned: %@", checkInTime);
        } else{
            NSLog(@"Check In Error: %@", error);
        }
    }];
    
}

-(void)checkOut:(Event *) event andBlock:(void(^)(Event *event)) block  {
    


    
    [UovoService checkOutForEvent:event.eventId withRequestHandler:^(NSError *error, NSDate* checkOutTime) {
        event.checkOutTime = checkOutTime;
        block(event);
        [event saveEvent];
        [self.tableView reloadData];

    } andCompletionHandler:^(NSError *error, NSDate * checkOutTime) {
        if(error == nil){
            NSLog(@"Check Out Request Returned: %@", checkOutTime);
        } else{
            NSLog(@"Check Out Error: %@", error);
        }
    }];
}

-(void)skip:(Event *)event andBlock:(void(^)(Event *event)) block  {
    
    [UovoService skipEvent:event.eventId withRequestHandler:^(NSError *error, BOOL skipped) {
        event.skipped = [NSNumber numberWithBool:skipped];
        block(event);
        [event saveEvent];
        
        [self.tableView reloadData];
    } andCompletionHandler:^(NSError *error, BOOL skipped) {
        if(error == nil){
            NSLog(@"Skip Request Returned: %@", [NSNumber numberWithBool:skipped]);
        } else{
            NSLog(@"Skip Error: %@", error);
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}


- (EventCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Event * event =[self.events objectAtIndex:indexPath.row];
    
    [cell formatForEvent:event];

    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Event * event = [self.events objectAtIndex:indexPath.row];
    
    EventViewController * viewController = [[EventViewController alloc] initWithEvent:event];
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
