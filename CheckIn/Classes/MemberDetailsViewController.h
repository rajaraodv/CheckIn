//
//  MemberDetailsControllerViewController.h
//  CheckIn
//
//  Created by Raja Rao DV on 2/5/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"


@interface MemberDetailsViewController : UIViewController<SFRestDelegate> {

   
}

@property (strong, nonatomic) IBOutlet UILabel *memberName;
@property (strong, nonatomic) IBOutlet UILabel *memberEmail;
@property (strong, nonatomic) IBOutlet UIImageView *memberPic;


@property (strong, nonatomic) IBOutlet UILabel *alertLabel;

- (IBAction)cancelBtn:(id)sender;


- (IBAction)checkinBtn:(id)sender;

@property (strong, atomic) NSString *memberStatus;
@property (strong, atomic) NSString *memberRecordId;
@property (strong, atomic) NSDictionary *memberRecord; //campaign member that contains lead or contact
@property (strong, atomic) NSDictionary *leadOrContact; //actual lead or contact

@end
