//
//  DraggingWindow.m
//  readMe
//
//  Created by hongjun kim on 11. 10. 15..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "DraggingWindow.h"

@implementation DraggingWindow
@synthesize textView;

- (NSString*)loadFile:(NSString *)file
{
	return [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
}

- (void)setTextViewString:(NSString*)file
{
	textView.string = [self loadFile:file];
}

- (void)lastFileLoad
{
	NSString* file = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastFile"];
	if ([file length]) {
		[self setTextViewString:file];
	}
	NSLog(@"lastFileLoad");
}

- (BOOL)isOneFile:(id)info
{
	NSArray *draggedFilenames = [[info draggingPasteboard] propertyListForType:NSFilenamesPboardType];
	if ([draggedFilenames count] > 1) {
		return NO;
	}
	return YES;
}

- (BOOL)isText:(id)info
{
	NSArray *draggedFilenames = [[info draggingPasteboard] propertyListForType:NSFilenamesPboardType];
	
    if ([[[draggedFilenames objectAtIndex:0] pathExtension] isEqual:@"txt"])
        return YES;
	else
        return NO;
}


- (BOOL)isPossible:(id)info
{
	return [self isOneFile:info]&&[self isText:info];
}


- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	
	if ([self isPossible:sender]) 
	{
		NSLog(@"draggingEntered NSDragOperationCopy");
		return NSDragOperationCopy;
	}
	
	NSLog(@"draggingEntered NSDragOperationNone");
	return NSDragOperationNone;
	
}

- (BOOL)performDragOperation:(id < NSDraggingInfo >)sender 
{
	NSLog(@"performDragOperation");
	return [self isPossible:sender];
}



- (void)concludeDragOperation:(id <NSDraggingInfo>)sender{

	NSArray *draggedFilenames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
	NSString *file = [draggedFilenames objectAtIndex:0];

	[[NSUserDefaults standardUserDefaults] setValue:file forKey:@"lastFile"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self setTextViewString:file];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"newFile" object:nil];
	
}
@end
