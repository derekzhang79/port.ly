//
//  LoadingView.h
//  Chorus
//
//  Created by Matt Cooper on 1/6/15.
//  Copyright (c) 2015 Chorus. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kParallaxIntensityDefault 30

#define kAlphaBG 0.7
#define kAlphaFloatingPanel 0.8

typedef enum LoadingState : NSInteger{
    LoadingStateFailure = -1,
    LoadingStateLoading,
    LoadingStateSuccess
} LoadingState;

@interface LoadingView : UIView

#pragma mark - Model

/// The LoadingState of the LoadingView
@property LoadingState state;

#pragma mark - UI

/// Sets the message displayed by the label. If not called, will display default message for state defined in -setState:
- (void)setMessage:(NSString *)message;

/// Sets the LoadingView to be invisible.
- (void)hide;
/// Makes the LoadingView visible.
- (void)show;


#pragma mark - TEST

/// Shift floatingPanel up in order to center (sometimes necessary with navbars)
- (void)shift;

@end
