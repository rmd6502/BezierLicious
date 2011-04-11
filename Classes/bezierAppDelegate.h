//
//  bezierAppDelegate.h
//  bezier
//
//  Created by Robert Diamond on 4/11/11.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@class bezierViewController;

@interface bezierAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    bezierViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet bezierViewController *viewController;

@end

