//
//  AppDelegate.m
//  QLab CasparCG ATEM Bridge
//
//  Created by Blair McMillan on 3/01/2014.
//  Copyright (c) 2014 Blair McMillan. All rights reserved.
//

#import "AppDelegate.h"
#import "GCDAsyncSocket.h"
#import "VVOSC/VVOSC.h"

@implementation AppDelegate
OSCManager					*manager;
OSCInPort					*inPort;
OSCOutPort					*outPort;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // create an OSCManager- set myself up as its delegate
    manager = [[OSCManager alloc] init];
    [manager setDelegate:self];
    
    // create an input port for receiving OSC data
    [manager createNewInputForPort:53001];
    
    
}
- (IBAction)handleCasparConnectButtonClick:(id)sender {
    
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError* error = Nil;
    if (![asyncSocket connectToHost:[self.casparIPAddressTextField stringValue] onPort:[[self.casparPortTextField stringValue] intValue] withTimeout:10 error:&error])
    {
        NSLog(@"Failed to connect to CasparCG");
        self.casparConnectButton.title = @"Connect";
        [self.casparCommandTextLabel setHidden:true];
        [self.casparCommandTextField setHidden:true];
        [self.casparSendCommandButton setHidden:true];
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
- (IBAction)handleQlabConnectButtonClick:(id)sender {
    // create an output so i can send OSC data to myself
    outPort = [manager createNewOutputToAddress:[self.qlabIPAddressTextField stringValue] atPort:53000];
    
    NSString *command = @"/version";
    OSCMessage *newMsg = [OSCMessage createWithAddress:command];
    [newMsg addFloat:1.0];
    [outPort sendThisMessage:newMsg];
    NSLog(@"sent %@", command);
}
- (void) receivedOSCMessage:(OSCMessage *)m	{
    NSArray *address = [[m address] componentsSeparatedByString:@"/"];
    if ([[address objectAtIndex:1] isEqualToString:@"reply"]) {
        NSString *jsonString = [m.value stringValue];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        NSLog(@"%@",json);
        NSString *status = [json valueForKey:@"status"];
        if (![status  isEqual: @"ok"]) {
            NSLog(@"Did not get an ok status");
        }
        
        if ([[address objectAtIndex:2] isEqualToString:@"version"]) {
            NSString *qlabVersion = [json valueForKey:@"data"];
            NSLog(@"data: %@", qlabVersion);
            [self.qlabVersionLabel setStringValue:[NSString stringWithFormat:@"QLab v%@", qlabVersion]];
            [self.qlabVersionLabel setHidden:false];
            [self.qlabCommandTextLabel setHidden:false];
            [self.qlabCommandTextField setHidden:false];
            [self.qlabSendCommandButton setHidden:false];
        }
    }
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Connected to CasparCG.");
    self.casparConnectButton.title = @"Connected";
    [self.casparCommandTextLabel setHidden:false];
    [self.casparCommandTextField setHidden:false];
    [self.casparSendCommandButton setHidden:false];
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
- (IBAction)qlabSendCommandButton:(id)sender {
    NSString *command = [self.qlabCommandTextField stringValue];
    OSCMessage *newMsg = [OSCMessage createWithAddress:command];
    [newMsg addFloat:1.0];
    [outPort sendThisMessage:newMsg];
    NSLog(@"sent %@", command);
}

- (IBAction)casparSendCommandButton:(id)sender {
    NSString *command = [[self.casparCommandTextField stringValue] stringByAppendingString:@"\r\n"];
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
- (IBAction)GithubPagePressed:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/sneat/QLab-CasparCG-Atem-Bridge/"]];
}
@end
