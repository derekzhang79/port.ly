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
	[self.shadowView.layer setCornerRadius:5];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self setupWithFlight:self.flight];
	
//	UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRect:self.rideView.bounds];
//	self.rideView.layer.masksToBounds = NO;
//	self.rideView.layer.shadowColor = [UIColor blackColor].CGColor;
//	self.rideView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//	self.rideView.layer.shadowOpacity = 0.5f;
//	self.rideView.layer.shadowPath = shadowPath2.CGPath;
}
- (void)viewDidLayoutSubviews{
	[super viewDidLayoutSubviews];
	
	UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.flightView.bounds];
	self.flightView.layer.masksToBounds = NO;
	self.flightView.layer.shadowColor = [UIColor blackColor].CGColor;
	self.flightView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
	self.flightView.layer.shadowOpacity = 0.3f;
	self.flightView.layer.shadowPath = shadowPath.CGPath;
	
	UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRect:self.rideView.bounds];
	self.shadowView.layer.masksToBounds = NO;
	self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
	self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
	self.shadowView.layer.shadowOpacity = 0.3f;
	self.shadowView.layer.shadowPath = shadowPath2.CGPath;
}

- (void)setupWithFlight:(Flight *)flight {
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"hh:mm a"];

	[self.airlineLabel setText:self.flight.airline];
	[self.fromAirportFull setText:self.flight.fromAirport];
	[self.fromAirportCode setText:self.flight.fromAirportCode];
	[self.toAirportFull setText:self.flight.toAirport];
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
	
	[self.toRideAirportLabel setText:[NSString stringWithFormat:@"To %@", self.flight.fromAirportCode]];
	[self.fromRideAirportLabel setText:[NSString stringWithFormat:@"From %@", self.flight.toAirportCode]];
	
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
	
//	NSDateFormatter *df = [[NSDateFormatter alloc] init];
//	[df setDateFormat:@"hh:mm a"];
//	[self.toRidePickupTimeLabel setText:[df stringFromDate:self.flight.toRidePickupTime]];
}
- (void)setupFromRide:(Ride *)ride {
	[self.fromRideDriverNameLabel setTextColor:[UIColor blackColor]];
	[self.fromRideLicenseLabel setTextColor:[UIColor blackColor]];
	
	[self.fromRideDriverImageView setImage:ride.driverImage];
	[self.fromRideDriverNameLabel setText:ride.name];
	[self.fromRideLicenseLabel setText:ride.license];
	
//	NSDateFormatter *df = [[NSDateFormatter alloc] init];
//	[df setDateFormat:@"hh:mm a"];
//	[self.fromRidePickupTimeLabel setText:[df stringFromDate:self.flight.fromRidePickupTime]];
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
//		[self.confirmButton setBackgroundColor:[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1]];
		[self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.confirmButton setTitle:@"Confirmed!" forState:UIControlStateNormal];
		
		UIView *confirmCircle = [[UIView alloc] initWithFrame:CGRectMake(self.confirmButton.frame.size.width/2 - 5, self.confirmButton.frame.size.height/2 - 5, 10, 10)];
		[confirmCircle.layer setCornerRadius:confirmCircle.frame.size.width / 2];
		[confirmCircle.layer setMasksToBounds:YES];
		[confirmCircle setBackgroundColor:[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1]];
		confirmCircle.userInteractionEnabled = NO;
		confirmCircle.exclusiveTouch = NO;
		[self.confirmButton addSubview:confirmCircle];
		
		[UIView animateWithDuration:2 animations:^{
			[confirmCircle setTransform:CGAffineTransformMakeScale(500, 500)];
			[confirmCircle setCenter:self.confirmButton.center];
		}];
		[self.confirmButton sendSubviewToBack:confirmCircle];
		
		//TEST:
		UIView *ride1BG = [[UIView alloc] initWithFrame:CGRectMake(-self.ride1View.frame.size.width, 0, self.ride1View.frame.size.width, self.ride1View.frame.size.height)];
		[self.ride1View addSubview:ride1BG];
		[ride1BG setBackgroundColor:[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1]];
		
		dispatch_queue_t bgQueue = dispatch_queue_create("bgQueue", NULL);
		dispatch_async(bgQueue, ^{
			[NSThread sleepForTimeInterval:1];
			dispatch_async(dispatch_get_main_queue(), ^{
				Ride *ride1 = [[Ride alloc]init];
				ride1.airportCode = self.flight.fromAirportCode;
				ride1.driverImage = [UIImage imageNamed:@"driver1"];
				ride1.name = @"Francis";
				ride1.license = @"804217";
				self.flight.toRidePickupTime = [NSDate date];
				
				[self setupToRide:ride1];
				
				[UIView transitionWithView:self.ride1View duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
					[self.toRideAirportLabel setTextColor:[UIColor whiteColor]];
					[self.toRideDriverNameLabel setTextColor:[UIColor whiteColor]];
					[self.toRideLicenseLabel setTextColor:[UIColor whiteColor]];
					[self.toRidePickupTimeLabel setTextColor:[UIColor whiteColor]];
					[self.toRideStaticDriver setTextColor:[UIColor whiteColor]];
					[self.toRideStaticLicense setTextColor:[UIColor whiteColor]];
					[self.toRideStaticPickup setTextColor:[UIColor whiteColor]];
				}completion:nil];
			});
		});
		
		[UIView animateWithDuration:0.5 delay:1.5 options:0 animations:^{
			CGRect newFrame = CGRectMake(0, 0, self.ride1View.frame.size.width, self.ride1View.frame.size.height);
			[ride1BG setFrame:newFrame];
			[self.ride1View sendSubviewToBack:ride1BG];
			[self.separatorView setAlpha:0];
		} completion:nil];
		
		
		

	}else {
		//TEST:
		UIView *ride2BG = [[UIView alloc] initWithFrame:CGRectMake(-self.ride2View.frame.size.width, 0, self.ride2View.frame.size.height, self.ride1View.frame.size.height)];
		[self.ride2View addSubview:ride2BG];
		[ride2BG setBackgroundColor:[UIColor colorWithRed:18/255.0 green:114/255.0 blue:131/255.0 alpha:1]];
		
		dispatch_queue_t bgQueue = dispatch_queue_create("bgQueue", NULL);
		dispatch_async(bgQueue, ^{
			dispatch_async(dispatch_get_main_queue(), ^{
				Ride *ride2 = [[Ride alloc]init];
				ride2.airportCode = self.flight.fromAirportCode;
				ride2.driverImage = [UIImage imageNamed:@"driver2"];
				ride2.name = @"Chelsea";
				ride2.license = @"VX352";
				
				[self setupFromRide:ride2];
				
				[UIView transitionWithView:self.ride2View duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
					[self.fromRideAirportLabel setTextColor:[UIColor whiteColor]];
					[self.fromRideDriverNameLabel setTextColor:[UIColor whiteColor]];
					[self.fromRideLicenseLabel setTextColor:[UIColor whiteColor]];
					[self.fromRidePickupTimeLabel setTextColor:[UIColor whiteColor]];
					[self.fromRideStaticDriver setTextColor:[UIColor whiteColor]];
					[self.fromRideStaticLicense setTextColor:[UIColor whiteColor]];
					[self.fromRideStaticPickup setTextColor:[UIColor whiteColor]];
				}completion:nil];
			});
		});
		
		[UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^{
			CGRect newFrame = CGRectMake(0, 0, self.ride2View.frame.size.width, self.ride2View.frame.size.height);
			[ride2BG setFrame:newFrame];
			[self.ride2View sendSubviewToBack:ride2BG];
		} completion:nil];
		
		[self.confirmButton setUserInteractionEnabled:NO];
	}
}

- (IBAction)cancel:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
