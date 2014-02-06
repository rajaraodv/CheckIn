//
//  LookupViewController.h
//  CheckIn
//
//  Created by Raja Rao DV on 2/3/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface LookupViewController : UIViewController <SFRestDelegate> {

}

@property (strong, nonatomic) IBOutlet UILabel *alertField;

@property (weak, nonatomic) UILabel *alertLabel;

@property (strong, nonatomic) NSDictionary *memberRecord;
@property (strong, nonatomic) NSDictionary *campaign;
@property (strong, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)emailFieldTextChanged:(id)sender;

- (IBAction)lookup:(id)sender;

- (IBAction)registerBtn:(id)sender;

@end
