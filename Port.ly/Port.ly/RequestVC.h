//
//  RequestVC.h
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RequestVC : UIViewController{
    MKMapView *mapview;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
