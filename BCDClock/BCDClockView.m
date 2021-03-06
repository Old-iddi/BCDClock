//
//  BCDClockView.m
//  Dennis Ionov iddi@me.com
//
// based on
//
//  MenuMeterCPUView.m
//
//	NSView for the menu extra
//
//	Copyright (c) 2002-2012 Alex Harper
//
// 	This file is part of MenuMeters.
//
// 	MenuMeters is free software; you can redistribute it and/or modify
// 	it under the terms of the GNU General Public License version 2 as
//  published by the Free Software Foundation.
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

#import "BCDClockView.h"

@implementation BCDClockView

///////////////////////////////////////////////////////////////
//
//	init/dealloc
//
///////////////////////////////////////////////////////////////

- initWithFrame:(NSRect)rect menuExtra:extra {

	// Use NSView initializer, not our undoc superclass
	self = [super initWithFrame:rect];
	if (!self) {
		return nil;
	}
	cpuMenuExtra = extra;
    return self;

} // initWithFrame

///////////////////////////////////////////////////////////////
//
//	View commands
//
///////////////////////////////////////////////////////////////

- (void)drawRect:(NSRect)rect {

	NSImage *image = [cpuMenuExtra image];
    if (image) {
		[image compositeToPoint:NSMakePoint(0, 1) operation:NSCompositeSourceOver];
	}

} // drawRect

@end
