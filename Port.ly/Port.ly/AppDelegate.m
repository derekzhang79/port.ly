//
//  AppDelegate.m
//  Port.ly
//
//  Created by Matt Cooper on 2/6/16.
//  Copyright © 2016 Matthew Cooper. All rights reserved.
//

#import "AppDelegate.h"
//#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate{
    CLLocation *currentLocation;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
    
    self.client = [MSClient
                   clientWithApplicationURLString:@"https://portly.azurewebsites.net"];
    
    //send location
  //  [[NSNotificationCenter defaultCenter] addObserverForName:@"currentLocationUpdated" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
    //    currentLocation = note.userInfo[@"currentLocation"];
    
   // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:latitude forKey:@"starLatitude"];
    //[defaults setObject:longitude forKey:@"starLongitude"];
    //[defaults synchronize];
    
   // MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    /*
    //send longitude
    NSDictionary *item1 = @{ @"startLat" : [defaults objectForKey:@"starLatitude"] };
    MSTable *itemTable1 = [client tableWithName:@"Flight"];
    [itemTable1 insert:item1 completion:^(NSDictionary *insertedItem, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
        }
    }];
    //send longitude
    NSDictionary *item2 = @{ @"startLon" : [defaults objectForKey:@"starLongitude"] };
    MSTable *itemTable2 = [client tableWithName:@"Flight"];
    [itemTable2 insert:item2 completion:^(NSDictionary *insertedItem, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
        }
    }];
     */
        
   // }];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    NSDictionary *item = @{ @"uber" : @"LAEL PLS" };
    MSTable *itemTable = [client tableWithName:@"User"];
    [itemTable insert:item completion:^(NSDictionary *insertedItem, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
        }
    }];
    
	
	UberKit *uberKit = [[UberKit alloc] initWithClientID:@"xHvfPvf0lGJ--RiPDo5D7j3DXYT7Vq7W" ClientSecret:@"BHutgVeczuhDjLvjSpBmWIIltdc2GyBq0Hw9NR_R" RedirectURL:@"portly://uber.com" ApplicationName:@"Port.ly"]; //Set these fields from your app on Uber Developers.
	uberKit.delegate = self; //Set the delegate (only for login)
	
	[uberKit startLogin];
	
	return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
	return YES;
}

#pragma mark - UberKitDelegate

- (void) uberKit: (UberKit *) uberKit didReceiveAccessToken: (NSString *) accessToken {
	//Got the access token, can now make requests for user data
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    NSDictionary *item = @{ @"uber" : accessToken };
    MSTable *itemTable = [client tableWithName:@"User"];
    [itemTable insert:item completion:^(NSDictionary *insertedItem, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
        }
    }];
	
}
- (void) uberKit: (UberKit *) uberKit loginFailedWithError: (NSError *) error {
	//An error occurred in the login process
}

@end
