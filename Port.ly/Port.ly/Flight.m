//
//  Flight.m
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import "Flight.h"

@implementation Flight

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.airline = @"";
		self.fromAirport = @"";
		self.toAirport = @"";
		self.fromAirportCode = @"";
		self.toAirportCode = @"";
		
		self.takeoffTimeScheduled = [[NSDate alloc]init];
		self.takeoffTimeReal = [[NSDate alloc]init];
		self.toRidePickupTime = [[NSDate alloc]init];
		self.fromRidePickupTime = [[NSDate alloc]init];
	}
	return self;
}

@end
