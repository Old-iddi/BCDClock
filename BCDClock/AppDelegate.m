//
//  AppDelegate.m
//  BCDClock
//
//  Created by Denis Ionov on 25/12/16.
//  Copyright © 2016 Denis Ionov. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
{
    BCDClockExtra *cpuExtra;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    cpuExtra=[[BCDClockExtra alloc] initWithBundle:[NSBundle mainBundle]];
    [cpuExtra configDisplay:@"BCDClockExtra" withTimerInterval:1.0];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
