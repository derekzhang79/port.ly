//
//  AppDelegate.h
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UberKit.h"
#import <MicrosoftAzureMobile/MicrosoftAzureMobile.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UberKitDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MSClient *client;

@end

