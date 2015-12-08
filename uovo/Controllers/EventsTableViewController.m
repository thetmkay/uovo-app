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
    
    
    self.events = [NSArray array];
    [self.tableView registerClass:[EventCell class] forCellReuseIdentifier:@"EventCell"];
    [self fetchEvents];
}



#pragma mark - Google Calendar Service Request

// Construct a query and get a list of upcoming events from the user calendar. Display the
// start dates and event summaries in the UITextView.
- (void)fetchEvents {
    
    ISO8601DateFormatter * formatter = [[ISO8601DateFormatter alloc] init];

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://localhost:3000/events" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * mutableEvents = [NSMutableArray array];
        for(NSDictionary * event in responseObject) {
            Event * ev = [[Event alloc] init];
            
            ev.title = [event objectForKey:@"title"];
            //ignore timezone
            ev.startTime = [formatter dateFromString:[event objectForKey:@"startDate"]];
            ev.endTime = [formatter dateFromString:[event objectForKey:@"endDate"]];
            ev.colorId = [[event objectForKey:@"colorId"] integerValue];
            
            [mutableEvents addObject:ev];
            
            NSLog(@"%@",[event objectForKey:@"name"]);
        }
        
        self.events = [NSArray arrayWithArray:mutableEvents];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //deal with error
        self.events = [NSArray array];
        [self.tableView reloadData];
        
        NSLog(@"Error: %@", operation );
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
