//
//  MemberDetailsControllerViewController.m
//  CheckIn
//
//  Created by Raja Rao DV on 2/5/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import "MemberDetailsViewController.h"
#import "Helper.h"

@interface MemberDetailsViewController ()

@end

@implementation MemberDetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //reset everything except memberRecord
    [self resetMe];
    
    self.memberStatus = [self.memberRecord objectForKey:@"Status"];
    self.memberRecordId = [self.memberRecord objectForKey:@"Id"];
    
    self.leadOrContact = [self getLeadOrContactForRecord:self.memberRecord];
    self.memberEmail.text = [self.leadOrContact objectForKey:@"Email"];
    self.memberName.text = [self.leadOrContact objectForKey:@"Name"];
}

- (void)resetMe {
    self.memberRecordId = @"";
    self.memberStatus = @"";
    self.leadOrContact = nil;
    self.memberEmail.text = @"";
    self.memberName.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)checkinBtn:(id)sender {
    [self doCheckin];
}

#pragma mark - Do update status

- (void)doCheckin
{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Responded", @"status",
                            nil];
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForUpdateWithObjectType:@"CampaignMember"
                                                                               objectId:self.memberRecordId
                                                                                 fields:fields];
  
    [[SFRestAPI sharedInstance] send:request delegate:self];
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
//success
    dispatch_async(dispatch_get_main_queue(), ^{
        self.alertLabel.hidden = NO;
        [[[Helper alloc] init] animateLabel: self.alertLabel withText:@"Successfully Checked In!" withBackgroundColor:nil];
        
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    
    NSLog(@"request:didFailLoadWithError: %@", error);
    //add your failed error handling here
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
    //add your failed error handling here
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    
    NSLog(@"requestDidTimeout: %@", request);
    //add your failed error handling here
}




#pragma mark - helper
- (NSDictionary *) getLeadOrContactForRecord:(NSDictionary *) record {
    NSDictionary *leadOrContact = [record objectForKey:@"Lead"];
    if(leadOrContact == (id)[NSNull null]) {
        leadOrContact = [record objectForKey:@"Contact"];
    }
    return leadOrContact;
}
@end
