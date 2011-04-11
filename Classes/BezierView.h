//
//  BezierView.h
//  bezier
//
//  Created by Robert Diamond on 4/11/11.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BezierView : UIView {

}

@property (nonatomic,assign) CGPoint a;
@property (nonatomic,assign) CGPoint b;
@property (nonatomic,assign) CGPoint c;
@property (nonatomic,assign) CGPoint d;

- (CGPoint)bezier:(double) t; // Parameter 0 <= t <= 1

@end
