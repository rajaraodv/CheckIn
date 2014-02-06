//
//  RegistrationViewController.m
//  CheckIn
//
//  Created by Raja Rao DV on 2/5/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import "RegistrationViewController.h"
#import "Helper.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

-(void) setMemberRecord:(NSDictionary *)memberRecord forCampaignId:(NSString *) campaignId {
    self.memberRecord = memberRecord;
    self.campaignId = campaignId;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetMe];
}

- (void)resetMe {
    self.firstNameField.text = @"";
    self.lastNameField.text = @"";
    self.emailField.text = nil;
    self.phoneField.text = @"";
    self.companyField.text = @"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAndCheckin:(id)sender {
    [self doRegister];
}


- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Do update status

- (void)doRegister
{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.firstNameField.text, @"FirstName",
                            self.lastNameField.text, @"LastName",
                            self.emailField.text, @"Email",
                            self.companyField.text, @"Company",
                            nil];
    
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForCreateWithObjectType:@"Lead" fields:fields];
    
    [[SFRestAPI sharedInstance] send:request delegate:self];
}
- (void) delayedPopCurrentView {
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}


- (void)checkInLeadWithId:(NSString *) leadId
{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Responded", @"status",
                            self.campaignId, @"CampaignId",
                            leadId, @"LeadId",
                            nil];
    NSLog(@"%@", fields);
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForCreateWithObjectType:@"CampaignMember" fields:fields];
    
    [[SFRestAPI sharedInstance] send:request delegate:self];
}

#pragma mark - SFRestAPIDelegate


- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    NSString *leadIdParamValue = [request.queryParams objectForKey:@"LeadId"];
    NSLog(@"%@", jsonResponse);
    if(leadIdParamValue == nil) {
       [self checkInLeadWithId: [jsonResponse objectForKey:@"id"]];

    } else {//registered AND Checked In
        dispatch_async(dispatch_get_main_queue(), ^{
            self.alertLabel.hidden = NO;
            [[[Helper alloc] init] animateLabel: self.alertLabel withText:@"Successfully Checked In!" withBackgroundColor:[UIColor greenColor]];
            
            //pop current view
            [self delayedPopCurrentView];
  
        });
    }
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"request:didFailLoadWithError: %@", error);
    dispatch_sync(dispatch_get_main_queue(), ^{
            self.alertLabel.hidden = NO;
            [[[Helper alloc] init] animateLabel: self.alertLabel withText:[error localizedDescription] withBackgroundColor:[UIColor orangeColor]];
    });
 }

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    NSLog(@"requestDidTimeout: %@", request);
    self.alertLabel.hidden = NO;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [[[Helper alloc] init] animateLabel: self.alertLabel withText:@"Request Time Out" withBackgroundColor:[UIColor orangeColor]];
    });
}

@end
