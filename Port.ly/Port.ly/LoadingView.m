//
//  LoadingView.m
//  Chorus
//
//  Created by Matt Cooper on 1/6/15.
//  Copyright (c) 2015 Chorus. All rights reserved.
//

/*
 TODO:
 - FIX: Figure out what is making -shift necesary in some VCs.
 
 */

#import "LoadingView.h"
#import "NGAParallaxMotion.h"

@implementation LoadingView{
    UIView *floatingPanel;
    UIActivityIndicatorView *activityIndicator;
    UIImageView *loadingImageView;
    UILabel *loadingLabel;
}

@synthesize state = _state;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:kAlphaBG]];
        [self setAlpha:kAlphaBG];
        
        floatingPanel = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 175, 175)];
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        loadingImageView = [[UIImageView alloc] init];
        loadingLabel = [[UILabel alloc]init];
        
        [floatingPanel setAlpha:kAlphaFloatingPanel];
        [floatingPanel.layer setCornerRadius:10];
        [floatingPanel setClipsToBounds:NO];//no so shadow works
        [floatingPanel setCenter:self.center];

        [floatingPanel setParallaxIntensity:kParallaxIntensityDefault];
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:floatingPanel.bounds cornerRadius:floatingPanel.layer.cornerRadius];
        [floatingPanel.layer setShadowPath:shadowPath.CGPath];
        [floatingPanel.layer setShadowRadius:5];
        [floatingPanel.layer setShadowOpacity:0.5];
        [floatingPanel.layer setShadowOffset:CGSizeMake(0, 0)];
        
        [activityIndicator startAnimating];
        [activityIndicator setFrame:CGRectMake(floatingPanel.frame.size.width/2 - 20, 40, 40, 40)];
        [floatingPanel addSubview:activityIndicator];
        
        [loadingImageView setFrame:CGRectMake(floatingPanel.frame.size.width/2 - 20, 40, 40, 40)];
        [floatingPanel addSubview:loadingImageView];
        
        [loadingLabel setFrame:CGRectMake(8, 105, 175-16, 50)];
        [loadingLabel setNumberOfLines:2];
        [loadingLabel setTextColor:[UIColor whiteColor]];
        [loadingLabel setTextAlignment:NSTextAlignmentCenter];
        [floatingPanel addSubview:loadingLabel];
        
        [self addSubview:floatingPanel];
        
        [self setState:LoadingStateLoading];
        
        [self hide];//start off hidden, because most VCs will want to add this as a subview on -viewDidLoad and then show later.
    }
    return self;
}

#pragma mark - State

- (void)setState:(LoadingState)state{
    _state = state;
	
	[floatingPanel setBackgroundColor:[UIColor colorWithRed:31/255.0 green:186/255.0 blue:214/255.0 alpha:1]];

    switch (self.state) {
        case LoadingStateLoading:
            //loading UI
            [activityIndicator setHidden:NO];
            [loadingImageView setHidden:YES];
            
            [self setMessage:@"Loading..."];
            break;
        case LoadingStateFailure:
            [loadingImageView setImage:[UIImage imageNamed:@"sadFace"]];
            [activityIndicator setHidden:YES];
            [loadingImageView setHidden:NO];
            
            [loadingLabel setText:@"Error\nPlease try later."];
            break;
        case LoadingStateSuccess:
            [loadingImageView setImage:[UIImage imageNamed:@"checkmark"]];
            [activityIndicator setHidden:YES];
            [loadingImageView setHidden:NO];
            
            [self setMessage:@"Success!"];
            break;
        default:
            break;
    }
}
- (LoadingState)state{
    return _state;
}

#pragma mark - UI

- (void)setMessage:(NSString *)message{
    [loadingLabel setText:message];
}

- (void)hide{
    [self setAlpha:0];
}
- (void)show{
    [self setAlpha:1];
}

#pragma mark - TEST

- (void)shift{
    [floatingPanel setCenter:CGPointMake(self.center.x, self.center.y - 64)];
}

@end
