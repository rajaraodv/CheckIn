//
//  LookupViewController.m
//  CheckIn
//
//  Created by Raja Rao DV on 2/3/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import "LookupViewController.h"
#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "MemberDetailsViewController.h"
#import "Helper.h"
#import "RegistrationViewController.h"

@interface LookupViewController ()

@end

@implementation LookupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.alertField.hidden = YES;
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.memberRecord = nil;
    self.emailField.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - buttons and fields listeners


- (IBAction)emailFieldTextChanged:(id)sender {
    self.alertField.hidden = YES;
}

- (IBAction)lookup:(id)sender {
    [self queryForCampaignMemberUsingEmail: self.emailField.text];
}

- (IBAction)registerBtn:(id)sender {
}


#pragma mark - query salesforce
- (void) queryForCampaignMemberUsingEmail:(NSString *)email {
    email = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([email length] == 0) {
        return;
    }
    NSString *query = @"SELECT Id,status,lead.name,lead.email,lead.phone,lead.id,contact.name,contact.id,contact.email,contact.phone FROM CampaignMember Where CampaignId = '%@' AND (lead.Email = '%@' OR contact.email = '%@') LIMIT 1";
    query = [NSString stringWithFormat:query, [self.campaign objectForKey:@"Id"], email, email];
    
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:query];
    [[SFRestAPI sharedInstance] send:request delegate:self];
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    
    NSLog(@"%@", jsonResponse);
    NSMutableArray *records = [jsonResponse objectForKey:@"records"];
    NSLog(@"request:didLoadResponse: #records: %d", records.count);
    
    if([records count] != 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.alertField.hidden = NO;
            [[[Helper alloc] init] animateLabel: self.alertField withText:nil withBackgroundColor:nil];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"%@", self.memberRecord);
            self.memberRecord = records[0];
            [self performSegue];

        });
    }
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"request:didFailLoadWithError: %@", error);
    //add your failed error handling here
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
    //add your failed error handling here
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    NSLog(@"requestDidTimeout: %@", request);
    //add your failed error handling here
}

#pragma mark - segue

- (void) performSegue {
    [self performSegueWithIdentifier:@"ShowMemberDetailsViewSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString: @"ShowMemberDetailsViewSegue"]) {
        MemberDetailsViewController *mdvc = [segue destinationViewController];
        [mdvc setMemberRecord:self.memberRecord];
    } else if([segue.identifier isEqualToString: @"ShowRegisterAndCheckInViewSegue"]){
        RegistrationViewController *rvc = [segue destinationViewController];
        [rvc setMemberRecord:self.memberRecord forCampaignId:[self.campaign objectForKey:@"Id"]];
    }
}

@end
