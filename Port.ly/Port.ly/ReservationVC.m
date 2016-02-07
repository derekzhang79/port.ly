//
//  ReservationVC.m
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ReservationVC.h"
#import "Flight.h"
#import "Ride.h"

@interface ReservationVC ()

@end

@implementation ReservationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self.toRideDriverNameLabel setText:@"Pending..."];
	[self.toRideLicenseLabel setText:@"Pending..."];
	[self.fromRideDriverNameLabel setText:@"Pending..."];
	[self.fromRideLicenseLabel setText:@"Pending..."];
	[self.toRideDriverNameLabel setTextColor:[UIColor lightGrayColor]];
	[self.toRideLicenseLabel setTextColor:[UIColor lightGrayColor]];
	[self.fromRideDriverNameLabel setTextColor:[UIColor lightGrayColor]];
	[self.fromRideLicenseLabel setTextColor:[UIColor lightGrayColor]];
	
	[self.confirmButton.layer setCornerRadius:5];
	[self.confirmButton.layer setMasksToBounds:YES];
	[self.confirmButton.layer setBorderColor:[[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1] CGColor]];
	[self.confirmButton.layer setBorderWidth:1];
	[self.confirmButton setBackgroundColor:[UIColor whiteColor]];
	[self.confirmButton setTitleColor:[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
	
	[self.toRideDriverImageView.layer setCornerRadius:self.toRideDriverImageView.frame.size.width/2];
	[self.toRideDriverImageView.layer setMasksToBounds:YES];
	[self.fromRideDriverImageView.layer setCornerRadius:self.fromRideDriverImageView.frame.size.width/2];
	[self.fromRideDriverImageView.layer setMasksToBounds:YES];
	
	[self.rideView.layer setCornerRadius:5];
	[self.rideView.layer setMasksToBounds:YES];
	[self.flightView.layer setCornerRadius:5];
	[self.flightView.layer setMasksToBounds:YES];
}

- (void)setupWithFlight:(Flight *)flight {
	self.flight = flight;
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"hh:mm a"];

	[self.airlineLabel setText:self.flight.airline];
	[self.fromAirportFull setText:self.flight.fromAirport];
	[self.fromAirportCode setText:self.flight.fromAirportCode];
	[self.toAirportFull setText:self.flight.toAirportCode];
	[self.toAirportCode setText:self.flight.toAirportCode];
	[self.takeoffTimeLabel setText:[df stringFromDate:self.flight.takeoffTimeScheduled]];
	
	NSTimeInterval delay = [self.flight.takeoffTimeReal timeIntervalSinceDate:self.flight.takeoffTimeScheduled];
	if (delay > 60) {
		[self.statusLabel setText:[NSString stringWithFormat:@"Delayed by %d minutes: %@", (int)delay/60, [df stringFromDate:self.flight.takeoffTimeReal ]]];
		[self.statusLabel setTextColor:[UIColor colorWithRed:255/255.0 green:57/255.0 blue:56/255.0 alpha:1]];
	} else {
		[self.statusLabel setText:@"On time"];
		[self.statusLabel setTextColor:[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1]];
	}
	
	[self.toRideAirportLabel setText:[NSString stringWithFormat:@"To %@", self.fromAirportCode]];
	[self.fromRideAirportLabel setText:[NSString stringWithFormat:@"From %@", self.toAirportCode]];
	
	[self.toRidePickupTimeLabel setText:[df stringFromDate:self.flight.toRidePickupTime]];
	[self.fromRidePickupTimeLabel setText:[df stringFromDate:self.flight.fromRidePickupTime]];

	self.confirmed = NO;
	[self.confirmButton setBackgroundColor:[UIColor whiteColor]];
	[self.confirmButton setTitleColor:[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
	[self.confirmButton setUserInteractionEnabled:YES];
}
- (void)setupToRide:(Ride *)ride {
	[self.toRideDriverNameLabel setTextColor:[UIColor blackColor]];
	[self.toRideLicenseLabel setTextColor:[UIColor blackColor]];
	
	[self.toRideDriverImageView setImage:ride.driverImage];
	[self.toRideDriverNameLabel setText:ride.name];
	[self.toRideLicenseLabel setText:ride.license];
}
- (void)setupFromRide:(Ride *)ride {
	[self.fromRideDriverNameLabel setTextColor:[UIColor blackColor]];
	[self.fromRideLicenseLabel setTextColor:[UIColor blackColor]];
	
	[self.fromRideDriverImageView setImage:ride.driverImage];
	[self.fromRideDriverNameLabel setText:ride.name];
	[self.fromRideLicenseLabel setText:ride.license];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirm:(id)sender {
	if (!self.confirmed) {
		self.confirmed = YES;
		
		//animate color change
		[self.confirmButton setBackgroundColor:[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1]];
		[self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.confirmButton setTitle:@"Confirmed!" forState:UIControlStateNormal];
		
		[self.confirmButton setUserInteractionEnabled:NO];
	}
}

- (IBAction)cancel:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
