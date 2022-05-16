//
//  BCDClockMenuExtra.h
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

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "BCDClockView.h"
#import "MenuMetersMenuExtraBase.h"

@interface BCDClockExtra : NSMenuExtra {

	// Menu Extra necessities
	NSMenu 							*theMenu;
    BCDClockView 				*theView;
	// The timers that call us
	NSTimer							*theMainTimer, *theEventLoopTimer;
	// The length of the menu item
	unsigned int					menuWidth;
	// Display render caches and cache info
	
} // BCDClockExtra

- initWithBundle:(NSBundle *)bundle;

- (void) renderNumberIn:(NSImage *)image atOffset:(int)offset what:(unsigned char)number;
- (void)updateBCDClock;
- (void)updateMenuWhenDown;
- (void)configFromPrefs:(NSNotification *)notification;

@end
