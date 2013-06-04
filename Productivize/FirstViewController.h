//
//  FirstViewController.h
//  Productivize
//
//  Created by Elijah Murray on 6/2/13.
//  Copyright (c) 2013 Blue Fantail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>


int Number = 1500;
int currentMinutes;
int currentSeconds;

@interface FirstViewController : UIViewController {
    SystemSoundID _pewPewSound;
}
@property (nonatomic, strong) IBOutlet UIButton *Start;
@property (nonatomic, strong) IBOutlet UIButton *Stop;
@property (nonatomic, strong) IBOutlet UIButton *Restart;
@property (nonatomic, strong) IBOutlet UILabel *seconds;
@property (nonatomic, strong) IBOutlet UILabel *minutes;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *currentTimerType;
@property (nonatomic, strong) NSArray *timerType;


- (IBAction)timerDone;
- (IBAction)Start:(id)sender;
- (IBAction)Stop:(id)sender;
- (IBAction)Restart:(id)sender;

- (void)countdown;

@end
