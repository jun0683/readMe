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
    NSString *textDataFile = [NSString stringWithContentsOfFile:[draggedFilenames objectAtIndex:0] encoding:NSUTF8StringEncoding error:nil];
	
	textView.string = textDataFile;
//    NSLog(@"%@", textDataFile);
} 

@end
