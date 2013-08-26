//
//  KeyboardPlugin.h
//  KeyboardPlugin
//
//  Created by Kenton Gray on 8/20/13.
//  Copyright (c) 2013 Kenton Gray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>


@interface KeyboardPlugin : CDVPlugin {
    BOOL _isVisible;
    CGSize _keyboardSize;
 
}
+ (KeyboardPlugin *)sharedInstance;
- (void)isVisibleCDV:(CDVInvokedUrlCommand*)command;
@property (nonatomic, readonly, getter=isVisible) BOOL visible;
@property NSString* callbackId;
@end