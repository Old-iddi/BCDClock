//
//  BCDClockMenuExtra.m
//  Dennis Ionov iddi@me.com
//
//
//  based on 
//	Menu Extra implementation
//
//	Copyright (c) 2002-2003 Alex Harper
//
// 	This file is part of MenuMeters.
// 
// 	MenuMeters is free software; you can redistribute it and/or modify
// 	it under the terms of the GNU General Public License as published by
// 	the Free Software Foundation; either version 2 of the License, or
// 	(at your option) any later version.
// 
// 	MenuMeters is distributed in the hope that it will be useful,
// 	but WITHOUT ANY WARRANTY; without even the implied warranty of
// 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// 	GNU General Public License for more details.
// 
// 	You should have received a copy of the GNU General Public License
// 	along with MenuMeters; if not, write to the Free Software
// 	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
// 

#import "BCDClockMenuExtra.h"
#import "MenuMeterWorkarounds.h"

@implementation BCDClockExtra

///////////////////////////////////////////////////////////////
//	
//	init/unload/dealloc
//
///////////////////////////////////////////////////////////////

- initWithBundle:(NSBundle *)bundle {

    // Menu item we are setting up at first
	NSMenuItem			*menuItem;
	
	// Allow super to init
	self = [super init];
	if(!self) {
		return nil;
	}
	
	// Setup our menu
	theMenu = [[NSMenu alloc] initWithTitle:@""];
	// Disable menu autoenabling
	[theMenu setAutoenablesItems:NO];
	
	 //Add load title and blanks for load display
    menuItem = (NSMenuItem *)[theMenu addItemWithTitle:@"BCDClock menu item" action:nil keyEquivalent:@""];
	NSCalendarDate *currentTime = [NSCalendarDate calendarDate];
	
	[[theMenu itemAtIndex:0] 
		setTitle:[currentTime description]];

	[menuItem setEnabled:NO];
        
	// Set the menu extra view up
    theView = [[BCDClockView alloc] initWithFrame:[[self view] frame] menuExtra:self];
    [self setView:theView];

    // Restart our timers
	theMainTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
						selector:@selector(updateBCDClock) userInfo:nil repeats:YES];
	
	// Resize the view
	[theView setFrameSize:NSMakeSize(30, [theView frame].size.height)];
	[self setLength:30];
											
	// Flag us for redisplay
	[theView setNeedsDisplay:YES]; 

	// Fake a timer call to config initial values
	[self updateBCDClock];
												
    return self;

} // initWithBundle

///////////////////////////////////////////////////////////////
//	
//	NSMenuExtra view callbacks
//
///////////////////////////////////////////////////////////////

- (NSImage *)image {    

    // Image we will subrender into
	NSImage						*currentImage = nil;
	// Loop
	unsigned int				i;
		
	// Allocate a new image. We render to an image instead of directly to the view in
	// the view class becuase it doesn't seem to impact performance at all (at least
	// compared to text render time) and means less messages between view and this class.
	// In fact, when I tested the other way (render direct in view) it seemed to slow down *sigh*
	currentImage = [[NSImage alloc] initWithSize:NSMakeSize(30, 20)];
	
	NSCalendarDate *currentTime = [NSCalendarDate calendarDate];
		
	unsigned char numbers[6];
	
	numbers[0] = (unsigned char)[currentTime hourOfDay]/10;
	numbers[1] = (unsigned char)[currentTime hourOfDay]%10;
	numbers[2] = (unsigned char)[currentTime minuteOfHour]/10;
	numbers[3] = (unsigned char)[currentTime minuteOfHour]%10;
	numbers[4] = (unsigned char)[currentTime secondOfMinute]/10;
	numbers[5] = (unsigned char)[currentTime secondOfMinute]%10;
	
	for (i = 0; i <= 5; i++) {
		[self renderNumberIn:currentImage atOffset:i what:(numbers[i]) ];
	}
    
    if (self.isMenuVisible) {
        [self updateMenuWhenDown];
    }
    
	return currentImage;
				
} // image

- (NSMenu *)menu {

	// Send the menu back to SystemUIServer
	return theMenu;

} // menu

///////////////////////////////////////////////////////////////
//	
//	Image renderers
//
///////////////////////////////////////////////////////////////

- (void) renderNumberIn:(NSImage *)image atOffset:(int)offset what:(unsigned char)number {
	int i;

    NSBezierPath *aPath = [NSBezierPath bezierPath];
	NSBezierPath *aPath2 = [NSBezierPath bezierPath];
	
	for( i=0; i<=3; i++)
	{
		if( number & (1<<i))
		{
			NSRect aRect = NSMakeRect(offset*5,i*4+2,4,3);
			[aPath appendBezierPathWithRect:aRect];
		}
		else
		{
			NSRect aRect = NSMakeRect(offset*5+1,i*4+2,2,3);
			[aPath2 appendBezierPathWithRect:aRect];
		}
	}
	
	[image lockFocus];
			[[NSColor whiteColor] set];
			[aPath fill];
			[[NSColor lightGrayColor] set];
			[aPath2 fill];
	[image unlockFocus];
		
} // renderNumberIn

- (void)updateBCDClock {
	
	// Force the view to update		
	[theView setNeedsDisplay:YES];
		
} // updateBCDClock

- (void)updateMenuWhenDown {

	NSCalendarDate *currentTime = [NSCalendarDate calendarDate];
	
	[[theMenu itemAtIndex:0] 
		setTitle:[currentTime description]];

    LiveUpdateMenuItemTitle(theMenu,
                            0,
                            [currentTime description]);
} // updateMenuWhenDown


- (void)configFromPrefs:(NSNotification *)notification {

    // Stop the current timers if needed, to prevent timer from firing inconveniently
	if (theMainTimer) {
		[theMainTimer invalidate];
		theMainTimer = nil;
	}
	if (theEventLoopTimer) {
		[theEventLoopTimer invalidate];
		theEventLoopTimer = nil;
	}
	
		
} // configFromPrefs

@end
