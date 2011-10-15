//
//  AppDelegate.h
//  readMe
//
//  Created by hongjun kim on 11. 10. 15..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DraggingWindow;

@interface AppDelegate : NSObject <NSApplicationDelegate,NSSpeechSynthesizerDelegate>

@property (assign) NSUInteger speackLocation;
@property (assign) IBOutlet DraggingWindow *window;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (nonatomic,retain) NSSpeechSynthesizer *synth;
- (IBAction)buttonDown:(id)sender;

@end
