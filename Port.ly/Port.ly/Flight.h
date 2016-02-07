//
//  Flight.h
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ride;

@interface Flight : NSObject

@property NSString *airline;
@property NSString *fromAirport;//airport being departed from
@property NSString *toAirport;//airport being landed at
@property NSString *fromAirportCode;
@property NSString *toAirportCode;
@property NSDate *takeoffTimeScheduled;
@property NSDate *takeoffTimeReal;
@property NSDate *arrivalTimeScheduled;
@property NSDate *arrivalTimeReal;
@property NSDate *toRidePickupTime;//ride to "fromAirport"
@property NSDate *fromRidePickupTime;//ride from "toAirport"

@property Ride *toRide;
@property Ride *fromRide;

@end
