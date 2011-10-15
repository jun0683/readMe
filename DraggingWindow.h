//
//  DraggingWindow.h
//  readMe
//
//  Created by hongjun kim on 11. 10. 15..
//  Copyright (c) 2011년 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface DraggingWindow : NSWindow
@property (unsafe_unretained) IBOutlet NSTextView *textView;
- (void)lastFileLoad;
@end
