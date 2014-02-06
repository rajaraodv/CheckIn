//
//  RegistrationViewController.h
//  CheckIn
//
//  Created by Raja Rao DV on 2/5/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface RegistrationViewController : UIViewController <SFRestDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *companyField;
@property (strong, nonatomic) IBOutlet UILabel *alertLabel;

@property (strong, atomic) NSDictionary *memberRecord;
@property (strong, atomic) NSString *campaignId; //campaignId of the campaign that the campaign member belongs to


-(void) setMemberRecord:(NSDictionary *)memberRecord forCampaignId:(NSString *) campaignId;

- (IBAction)registerAndCheckin:(id)sender;
- (IBAction)cancelBtn:(id)sender;

@end
