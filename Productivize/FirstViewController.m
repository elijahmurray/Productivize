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
@synthesize currentTimerType;
@synthesize timerType;

- (void)viewDidLoad
{
    [super viewDidLoad];
	timerType = [NSArray arrayWithObjects:@"Pomodoro",@"Break", nil];

    NSString *pewPewPath = [[NSBundle mainBundle] pathForResource:@"pew-pew-lei" ofType:@"caf"];
    NSLog(@"%@", pewPewPath);
	NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &_pewPewSound);

}

-(IBAction)Start:(id)sender {
    [self startTimer];
    AudioServicesPlaySystemSound(_pewPewSound);
}

-(IBAction)Stop:(id)sender {
    [timer invalidate];
    [Start setEnabled:YES];
}

-(IBAction)Restart:(id)sender {
    Number = 1500; //25 minutes in seconds was 1500
    AudioServicesPlaySystemSound(_pewPewSound);
}


-(void)startTimer {
    currentTimerType = timerType[0];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [Start setEnabled:NO];

}

-(void)countdown {
    Number = Number -1;
    [self updateTime];
    
    if (Number <= 0) {
        [timer invalidate];
        [self timerDone];
    }
}
-(void)updateTime {
    currentMinutes = floor(Number / 60);
    currentSeconds = fmod(Number, 60);
    minutes.text = [NSString stringWithFormat:@"%i", currentMinutes];
    seconds.text = [NSString stringWithFormat:@"%i", currentSeconds];
}

- (IBAction)timerDone {
    
    int opposite = 0;
    if (currentTimerType == timerType[0]) { opposite = 1; }
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
    Number = 300; //full number should be 300
    [self startTimer];
    currentTimerType = timerType[1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
