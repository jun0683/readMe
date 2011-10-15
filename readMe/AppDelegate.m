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
@synthesize speackLength = _speackLength;
@synthesize speackOffset = _speackOffset;
@synthesize first;

#pragma mark - life cycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self loadLastSpeackLocation];
	[_window lastFileLoad];
	[_window registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
	
	NSRect scrollviewframe = [[_textView superview] frame];
	[_textView setFrame:scrollviewframe];
	
	[self scrollTextView:NSMakeRange(_speackLocation, 0)];
	
	
	
	
	self.synth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
	[_synth setDelegate:self];
	
	first = YES;
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newFile) name:@"newFile" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textSelected:) name:NSTextViewDidChangeSelectionNotification object:nil];
}


- (void)applicationWillTerminate:(NSNotification *)notification
{
	[self saveLastSpeackLocation];
}

#pragma mark - noti

- (void)newFile
{
	first = YES;
	_speackOffset = _speackLocation = 0;
}

- (void)textSelected:(NSNotification*)noti
{
	[self stop];
	
	_speackOffset = _speackLocation = [_textView selectedRange].location;
	first = YES;
	
	[self read];
	
}

#pragma mark - load/save

- (void)loadLastSpeackLocation
{
	_speackOffset = _speackLocation = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastspeackLocation"] intValue];
	
}

- (void)saveLastSpeackLocation
{
	[[NSUserDefaults standardUserDefaults] setInteger:_speackLocation+_speackLength+_speackOffset forKey:@"lastspeackLocation"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - button Event

- (void)read
{
	if (first) 
	{
		[_synth stopSpeaking];
		[_synth startSpeakingString:[_textView.string substringFromIndex:_speackLocation]];
		first = NO;
	}
	else
	{
		[_synth continueSpeaking];
	}
}

- (void)stop
{
	[_synth pauseSpeakingAtBoundary:NSSpeechWordBoundary];
}

- (IBAction)buttonToggle:(id)sender {

	if ([_synth isSpeaking]) {
		[self stop];
	}
	else
	{
		[self read];
	}
	
}

#pragma mark - NSSpeechSynthesizerDelegate

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)characterRange ofString:(NSString *)string
{
	_speackLocation = characterRange.location;
	_speackLength = characterRange.length;
	
	[self scrollTextView:NSMakeRange(characterRange.location+_speackOffset, characterRange.length)];
}

#pragma mark - scroll

- (void)scrollTextView:(NSRange)range
{
	NSRect insertionRect=[[_textView layoutManager] boundingRectForGlyphRange:range 
															  inTextContainer:[_textView textContainer]];
	[_textView scrollPoint:insertionRect.origin];
}



@end
