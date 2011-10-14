//
//  AppDelegate.m
//  readMe
//
//  Created by hongjun kim on 11. 10. 15..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	NSSpeechSynthesizer *synth = [[NSSpeechSynthesizer alloc] initWithVoice:@"com.apple.speech.synthesis.voice.Alex"];
	[synth startSpeakingString:@"Hello world!"];
	
	//http://stackoverflow.com/questions/837582/mac-osx-speech-to-text-api-how-to
	
}

@end
