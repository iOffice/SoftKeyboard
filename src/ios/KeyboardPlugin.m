//
//  KeyboardPlugin.m
//  KeyboardPlugin
//
//  Created by Kenton Gray on 8/20/13.
//
/*
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
* an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
* specific language governing permissions and limitations under the License.
*
*/

#import "KeyboardPlugin.h"

@implementation KeyboardPlugin


static KeyboardPlugin *sharedInstance;



- (BOOL)isVisible
{
    return _isVisible;
}
- (CGSize) keyboardSize {
    return _keyboardSize;
}

- (void)isVisibleCDV:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[sharedInstance isVisible]];
   
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)getSizeCDV:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
      NSDictionary *size = @{ @"width" :[NSNumber numberWithFloat:[sharedInstance keyboardSize].width], @"height" :[NSNumber numberWithFloat:[sharedInstance keyboardSize].height]};
    if(sharedInstance.isVisible) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: size];
    }
    else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: @{ @"height" : @0, @"width" : @0}];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
//Start cordova so we get our callback
- (void)start:(CDVInvokedUrlCommand*)command
{
    sharedInstance.callbackId =command.callbackId;

    [self didShow:nil];
}

- (void)didShow:(NSNotification *)notification
{
    
    _isVisible = YES;
    NSDictionary* info = [notification userInfo];
    _keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSDictionary *size = @{ @"width" :[NSNumber numberWithFloat:_keyboardSize.width], @"height" :[NSNumber numberWithFloat:_keyboardSize.height]};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"type": @"showKeyboard", @"size": size}];
    pluginResult.keepCallback = @YES;
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:sharedInstance.callbackId];

   // pluginResult.keepCallback = @YES;
  //  [//self.commandDelegate sendPluginResult:pluginResult callbackId:sharedInstance.callbackId];
}
- (CDVPlugin*)initWithWebView:(UIWebView*)theWebView {
    sharedInstance = self;
    if ((self = [super init])) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(didShow:) name:UIKeyboardDidShowNotification object:nil];
        [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
    
}
- (void)didHide
{
    _isVisible = NO;
    
    
}@end
