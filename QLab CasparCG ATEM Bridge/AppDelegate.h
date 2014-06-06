//
//  AppDelegate.h
//  QLab CasparCG ATEM Bridge
//
//  Created by Blair McMillan on 3/01/2014.
//  Copyright (c) 2014 Blair McMillan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class GCDAsyncSocket;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    GCDAsyncSocket *asyncSocket;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *casparIPAddressTextField;
@property (weak) IBOutlet NSTextField *casparPortTextField;
@property (weak) IBOutlet NSButton *casparConnectButton;
@property (weak) IBOutlet NSTextField *casparCommandTextLabel;
@property (weak) IBOutlet NSTextField *casparCommandTextField;
@property (weak) IBOutlet NSButton *casparSendCommandButton;
@property (weak) IBOutlet NSButton *countdownTimerButton;
@property (weak) IBOutlet NSButton *hideTimerButton;
@property (weak) IBOutlet NSTextField *minutesLabel;
@property (weak) IBOutlet NSTextField *minutesTextField;
@property (weak) IBOutlet NSTextField *secondsLabel;
@property (weak) IBOutlet NSTextField *secondsTextField;
@property (weak) IBOutlet NSTextField *layerLabel;
@property (weak) IBOutlet NSTextField *layerTextField;
@property (weak) IBOutlet NSTextField *templateLabel;
@property (weak) IBOutlet NSTextField *templateTextField;
@property (weak) IBOutlet NSTextField *qlabIPAddressTextField;
@property (weak) IBOutlet NSButton *qlabConnectButton;
@property (weak) IBOutlet NSTextField *qlabCommandTextLabel;
@property (weak) IBOutlet NSTextField *qlabCommandTextField;
@property (weak) IBOutlet NSButton *qlabSendCommandButton;
@property (weak) IBOutlet NSTextField *qlabVersionLabel;
@property (unsafe_unretained) IBOutlet NSTextView *qlabDocumentationLabel;

@end
