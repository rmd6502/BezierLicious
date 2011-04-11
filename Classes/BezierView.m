//
//  BezierView.m
//  bezier
//
//  Created by Robert Diamond on 4/11/11.
//  Copyright 2011 none. All rights reserved.
//

#import "BezierView.h"

static const double EPSILON = .005;

CGPoint addPoints(CGPoint a,CGPoint other) {
	return CGPointMake(a.x+other.x, a.y+other.y);
}

CGPoint scalarMult(CGPoint a, double sc) {
	return CGPointMake(a.x*sc, a.y*sc);
}


@implementation BezierView
@synthesize a,b,c,d;
	
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextMoveToPoint(ctx, a.x, a.y);
	for (double t = 0; t < 1; t += EPSILON) {
		CGPoint p = [self bezier:t];
		CGContextAddLineToPoint(ctx, p.x, p.y);
	}
	CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
	CGContextSetLineWidth(ctx, 2.25);
	CGContextSetLineCap(ctx, kCGLineCapRound);
	CGContextSetLineJoin(ctx, kCGLineJoinRound);
	CGContextStrokePath(ctx);
	
	CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
	CGContextFillEllipseInRect(ctx, CGRectMake(a.x-5, a.y-5, 10, 10));
	CGContextFillEllipseInRect(ctx, CGRectMake(b.x-5, b.y-5, 10, 10));
	CGContextFillEllipseInRect(ctx, CGRectMake(c.x-5, c.y-5, 10, 10));
	CGContextFillEllipseInRect(ctx, CGRectMake(d.x-5, d.y-5, 10, 10));
	
	CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
	CGContextMoveToPoint(ctx, a.x, a.y);
	CGContextAddLineToPoint(ctx, b.x, b.y);
	CGContextMoveToPoint(ctx, c.x, c.y);
	CGContextAddLineToPoint(ctx, d.x, d.y);
	CGContextStrokePath(ctx);
}


- (void)dealloc {
    [super dealloc];
}

- (CGPoint)bezier:(double) t // Parameter 0 <= t <= 1
{
    double s = 1 - t;
	CGPoint AB = addPoints(scalarMult(a,s), scalarMult(b, t));
	CGPoint BC = addPoints(scalarMult(b,s), scalarMult(c, t));
	CGPoint CD = addPoints(scalarMult(c,s), scalarMult(d, t));
	CGPoint ABC = addPoints(scalarMult(AB,s), scalarMult(BC, t));
	CGPoint BCD = addPoints(scalarMult(BC,s), scalarMult(CD, t));
    return addPoints(scalarMult(ABC,s), scalarMult(BCD, t));
}

@end
