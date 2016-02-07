//
//  ReservationVC.h
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *airlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromAirportFull;
@property (weak, nonatomic) IBOutlet UILabel *fromAirportCode;
@property (weak, nonatomic) IBOutlet UILabel *toAirportFull;
@property (weak, nonatomic) IBOutlet UILabel *toAirportCode;
@property (weak, nonatomic) IBOutlet UILabel *takeoffTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *toRideAirportLabel;
@property (weak, nonatomic) IBOutlet UIImageView *toRideDriverImageView;
@property (weak, nonatomic) IBOutlet UILabel *toRideDriverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *toRideLicenseLabel;
@property (weak, nonatomic) IBOutlet UILabel *toRidePickupTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *fromRideAirportLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fromRideDriverImageView;
@property (weak, nonatomic) IBOutlet UILabel *fromRideDriverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromRideLicenseLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromRidePickupTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
- (IBAction)confirm:(id)sender;

- (IBAction)cancel:(id)sender;

@end