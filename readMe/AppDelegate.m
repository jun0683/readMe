//
//  AppDelegate.m
//  readMe
//
//  Created by hongjun kim on 11. 10. 15..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "DraggingWindow.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize textView = _textView;
@synthesize synth = _synth;
@synthesize speackLocation = _speackLocation;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[_window lastFileLoad];
	[_window registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
	
	NSRect scrollviewframe = [[_textView superview] frame];
	[_textView setFrame:scrollviewframe];
	
	_speackLocation = 0;
	
	self.synth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
	[_synth setDelegate:self];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	
}

- (IBAction)buttonDown:(id)sender {
	NSLog(@"%@",sender);
	if ([_synth isSpeaking]) {
		[_synth pauseSpeakingAtBoundary:NSSpeechWordBoundary];
	}
	else
	{
		if (_speackLocation) 
		{
			[_synth continueSpeaking];
		}
		else
		{
			[_synth startSpeakingString:_textView.string];
		}
			
	}
	
}

#pragma mark - NSSpeechSynthesizerDelegate

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)characterRange ofString:(NSString *)string
{
//	NSLog(@"willSpeakWord %@ %@",[string substringWithRange:characterRange],NSStringFromRange(characterRange));
	_speackLocation = characterRange.location;
//	[_textView setSelectedRange:characterRange];
//	[_textView showFindIndicatorForRange:characterRange];
	
	NSRect insertionRect=[[_textView layoutManager] boundingRectForGlyphRange:characterRange inTextContainer:[_textView textContainer]];
//	NSPoint scrollPoint=NSMakePoint(0,insertionRect.origin.y+insertionRect.size.height+50-[[NSScreen mainScreen] frame].size.height);
//	NSLog(@"%@",NSStringFromPoint(insertionRect));
	[_textView scrollPoint:insertionRect.origin];
}





@end
