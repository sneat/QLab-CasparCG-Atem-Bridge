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
@property (weak) IBOutlet NSTextField *ipAddressTextField;
@property (weak) IBOutlet NSTextField *portTextField;
@property (weak) IBOutlet NSButton *connectButton;
@property (weak) IBOutlet NSTextField *commandTextLabel;
@property (weak) IBOutlet NSTextField *commandTextField;
@property (weak) IBOutlet NSButton *sendCommandButton;
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

@end
