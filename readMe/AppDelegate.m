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
	// Insert code here to initialize your application
	self.synth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
	[_synth setDelegate:self];
	
	[_window registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
	
	NSRect scrollviewframe = [[_textView superview] frame];
	[_textView setFrame:scrollviewframe];
	
	_speackLocation = 0;
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

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking
{
	NSLog(@"didFinishSpeaking");
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)characterRange ofString:(NSString *)string
{
	
	NSLog(@"willSpeakWord %@ %@",[string substringWithRange:characterRange],NSStringFromRange(characterRange));
	_speackLocation = characterRange.location;
	[_textView setSelectedRange:characterRange];
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakPhoneme:(short)phonemeOpcode
{
	NSLog(@"willSpeakPhoneme");
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender 
 didEncounterErrorAtIndex:(NSUInteger)characterIndex 
				 ofString:(NSString *)string 
				  message:(NSString *)message 
{
	NSLog(@"didEncounterErrorAtIndex");
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didEncounterSyncMessage:(NSString *)message 
{
	NSLog(@"didEncounterSyncMessage");
}



@end
