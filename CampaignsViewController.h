//
//  CampaignsViewController.h
//  CheckIn
//
//  Created by Raja Rao DV on 2/4/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface CampaignsViewController : UITableViewController <SFRestDelegate, UISearchBarDelegate> {

    IBOutlet UITableView *tableView;
}

@property (nonatomic, strong) NSMutableArray *dataRows;
//@property (nonatomic, strong) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UISearchBar *searchField;

-(void) query: (NSString *) searchString;
@end
