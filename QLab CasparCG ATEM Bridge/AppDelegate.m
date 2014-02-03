//
//  AppDelegate.m
//  QLab CasparCG ATEM Bridge
//
//  Created by Blair McMillan on 3/01/2014.
//  Copyright (c) 2014 Blair McMillan. All rights reserved.
//

#import "AppDelegate.h"
#import "GCDAsyncSocket.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}
- (IBAction)handleConnectButtonClick:(id)sender {
    
    NSLog(@"Ready to create socket");
    
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError* error = Nil;
    if (![asyncSocket connectToHost:[self.ipAddressTextField stringValue] onPort:[[self.portTextField stringValue] intValue] withTimeout:10 error:&error])
    {
        NSLog(@"Failed to create socket");
        self.connectButton.title = @"Connect";
        [self.commandTextField setHidden:true];
        [self.sendCommandButton setHidden:true];
    }
    
}
- (IBAction)sendCommandButton:(id)sender {
    NSString *command = [[self.commandTextField stringValue] stringByAppendingString:@"\r\n"];
    [asyncSocket writeData:[command dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] withTimeout:-1 tag:1];
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Cool, I'm connected! That was easy.");
    self.connectButton.title = @"Connected";
    [self.commandTextField setHidden:false];
    [self.sendCommandButton setHidden:false];
}
@end
