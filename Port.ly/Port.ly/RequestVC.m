//
//  RequestVC.m
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import "RequestVC.h"

@interface RequestVC ()

@end

@implementation RequestVC {
    CLLocation *currentLocation;
}

@synthesize mapView = _mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationManager = [CLLocationManager new];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
//    self.mapView = [[MKMapView alloc]
//               initWithFrame:CGRectMake(0,
//                                        0,
//                                        self.view.bounds.size.width,
//                                        self.view.bounds.size.height)
//               ];
    self.mapView.showsUserLocation = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.delegate = self;
//[self.mapView setDelegate:self];
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:mapView];
	
	[self.reservationTypeControl.layer setCornerRadius:3];
	[self.goButton.layer setCornerRadius:3];
	[self.goButton setClipsToBounds:YES];
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
  //  [mapView setRegion:MKCoordinateRegionMake(currentLocation.coordinate,MKCoordinateSpanMake(0.02, 0.02)) animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    currentLocation = locations.lastObject;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mapTapped:(id)sender {
	[self resignFirstResponder];
}
@end
