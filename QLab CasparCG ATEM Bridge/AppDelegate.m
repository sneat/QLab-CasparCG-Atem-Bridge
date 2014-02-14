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
    
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError* error = Nil;
    if (![asyncSocket connectToHost:[self.ipAddressTextField stringValue] onPort:[[self.portTextField stringValue] intValue] withTimeout:10 error:&error])
    {
        NSLog(@"Failed to connect to CasparCG");
        self.connectButton.title = @"Connect";
        [self.commandTextLabel setHidden:true];
        [self.commandTextField setHidden:true];
        [self.sendCommandButton setHidden:true];
        [self.countdownTimerButton setHidden:true];
        [self.hideTimerButton setHidden:true];
        [self.minutesLabel setHidden:true];
        [self.minutesTextField setHidden:true];
        [self.secondsLabel setHidden:true];
        [self.secondsTextField setHidden:true];
        [self.layerLabel setHidden:true];
        [self.layerTextField setHidden:true];
        [self.templateLabel setHidden:true];
        [self.templateTextField setHidden:true];
    }
    
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Connected to CasparCG.");
    self.connectButton.title = @"Connected";
    [self.commandTextLabel setHidden:false];
    [self.commandTextField setHidden:false];
    [self.sendCommandButton setHidden:false];
    [self.countdownTimerButton setHidden:false];
    [self.hideTimerButton setHidden:false];
    [self.minutesLabel setHidden:false];
    [self.minutesTextField setHidden:false];
    [self.secondsLabel setHidden:false];
    [self.secondsTextField setHidden:false];
    [self.layerLabel setHidden:false];
    [self.layerTextField setHidden:false];
    [self.templateLabel setHidden:false];
    [self.templateTextField setHidden:false];
}

- (IBAction)sendCommandButton:(id)sender {
    NSString *command = [[self.commandTextField stringValue] stringByAppendingString:@"\r\n"];
    [asyncSocket writeData:[command dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] withTimeout:-1 tag:1];
}

- (IBAction)hideTimerButton:(id)sender {
    NSString *layer = [self.layerTextField stringValue];
    NSString *command = [NSString stringWithFormat:@"STOP %@ \r\n", layer];
    [asyncSocket writeData:[command dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] withTimeout:-1 tag:1];
}

- (IBAction)countdownTimerButton:(id)sender {
    NSString *layer = [self.layerTextField stringValue];
    NSString *template = [self.templateTextField stringValue];
    NSString *minutes = [self.minutesTextField stringValue];
    NSString *seconds = [self.secondsTextField stringValue];
    NSString *formatted = [NSString stringWithFormat:@"%02d:%02d", [minutes intValue], [seconds intValue]];
    NSString *command = [NSString stringWithFormat:@"CG %@ ADD 0 \"%@\" 1 \"<templateData><componentData id=\\\"timer_txt\\\"><data id=\\\"text\\\" value=\\\"%@\\\"></data> </componentData><componentData id=\\\"minn\\\"><data id=\\\"text\\\" value=\\\"%@\\\"></data></componentData><componentData id=\\\"secc\\\"><data id=\\\"text\\\" value=\\\"%@\\\"></data></componentData><componentData id=\\\"Dirr\\\"><data id=\\\"text\\\" value=\\\"down\\\"></data></componentData></templateData>\"\r\n", layer, template, formatted, minutes, seconds];
    [asyncSocket writeData:[command dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] withTimeout:-1 tag:1];
    command = [NSString stringWithFormat:@"CG %@ INVOKE 0 \"TimeStart\"\r\n", layer];
    [asyncSocket writeData:[command dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] withTimeout:-1 tag:1];
}
@end
