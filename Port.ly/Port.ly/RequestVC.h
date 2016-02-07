//
//  RequestVC.h
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RequestVC : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    MKMapView *mapView;
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *flightNumTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *reservationTypeControl;

@end
