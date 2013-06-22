//
//  FirstViewController.m
//  Productivize
//
//  Created by Elijah Murray on 6/2/13.
//  Copyright (c) 2013 Blue Fantail. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize Start;
@synthesize Stop;
@synthesize Restart;
@synthesize timer;
@synthesize minutes;
@synthesize seconds;
@synthesize pomoCount;
@synthesize currentTimerType;
@synthesize timerType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateTime];
    [self initializeAudio];
	timerType = [NSArray arrayWithObjects:@"Pomodoro",@"Break", nil];
    
    //set initial timer as pomodoro
    currentTimerType = timerType[0];
    [Restart setHidden:YES];
}

-(IBAction)Start:(id)sender {
    [self startTimer];
    AudioServicesPlaySystemSound(_alertSound);
    [Start setHidden:YES];
    [Restart setHidden:NO];
    
}

-(IBAction)Stop:(id)sender {
    [timer invalidate];
    [Start setEnabled:YES];
    [Start setHidden:NO];
    [Restart setHidden:YES];
}

-(IBAction)Restart:(id)sender {
    Number = 1500; //25 minutes in seconds was 1500
    AudioServicesPlaySystemSound(_alertSound);
}

-(void)initializeAudio {
    //setup the audio sound
    NSString *alertPath = [[NSBundle mainBundle] pathForResource:@"pew-pew-lei" ofType:@"caf"];
	NSURL *alertURL = [NSURL fileURLWithPath:alertPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)alertURL, &_alertSound);
}

-(void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [Start setEnabled:NO];
}

-(void)countdown {
    Number = Number -5;
    [self updateTime];
    
    if (Number <= 0) {
        [timer invalidate];
        [self timerDone];
    }
}
-(void)updateTime {
    currentMinutes = floor(Number / 60);
    currentSeconds = fmod(Number, 60);
    minutes.text = [NSString stringWithFormat:@"%.2i", currentMinutes];
    seconds.text = [NSString stringWithFormat:@"%.2i", currentSeconds];
}
- (void) updatePomoCount {
    completedPomos++;
    pomoCount.text = [NSString stringWithFormat:@"%i",completedPomos];
    
}


- (IBAction)timerDone {
    int opposite = 0;
    
    //if a pomo was completed
    if (currentTimerType == timerType[0]) { opposite = 1; [self updatePomoCount];}
    else{ opposite = 0; }
    
    NSString *messageText = [NSString stringWithFormat:@"You completed a %@",currentTimerType];
    NSString *timerCompleted = [NSString stringWithFormat:@"%@ Completed", currentTimerType];
    NSString *cancelButton = [NSString stringWithFormat:@"Start %@", [timerType objectAtIndex:opposite] ];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: timerCompleted
                              message:messageText
                              delegate: self
                              cancelButtonTitle:cancelButton
                              otherButtonTitles: nil];
    [alertView show];

}

//What do to when dismissing the break
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (currentTimerType == timerType[0]) {
            Number = 300; //full number should be 300
            currentTimerType = timerType[1];
    }
    else if (currentTimerType == timerType[1]) {
        Number = 1500;
        currentTimerType = timerType[0];
    }
    [self startTimer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
