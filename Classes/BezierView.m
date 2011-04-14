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
	
	CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
	CGContextMoveToPoint(ctx, a.x, a.y);
	CGContextAddLineToPoint(ctx, b.x, b.y);
	CGContextMoveToPoint(ctx, c.x, c.y);
	CGContextAddLineToPoint(ctx, d.x, d.y);
	CGContextStrokePath(ctx);
	
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
	
	CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
	CGContextSelectFont(ctx, "Helvetica", 18.0, kCGEncodingMacRoman);
	CGContextSetTextDrawingMode(ctx, kCGTextFill);
	CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1.0, -1.0));
	NSString *label = [NSString stringWithFormat:@"(%.0f,%.0f)", a.x, a.y];
	CGContextShowTextAtPoint(ctx, fmax(30, fmin(self.bounds.size.width - 80, a.x - 10)), fmax(30, fmin(self.bounds.size.height - 44, a.y + 10)), [label UTF8String], [label length]);
	label = [NSString stringWithFormat:@"(%.0f,%.0f)", b.x, b.y];
	CGContextShowTextAtPoint(ctx, fmax(30, fmin(self.bounds.size.width - 80, b.x - 10)), fmax(30, fmin(self.bounds.size.height - 44, b.y + 10)), [label UTF8String], [label length]);
	label = [NSString stringWithFormat:@"(%.0f,%.0f)", c.x, c.y];
	CGContextShowTextAtPoint(ctx, fmax(30, fmin(self.bounds.size.width - 80, c.x - 10)), fmax(30, fmin(self.bounds.size.height - 44, c.y + 10)), [label UTF8String], [label length]);
	label = [NSString stringWithFormat:@"(%.0f,%.0f)", d.x, d.y];
	CGContextShowTextAtPoint(ctx, fmax(30, fmin(self.bounds.size.width - 80, d.x - 10)), fmax(30, fmin(self.bounds.size.height - 44, d.y + 10)), [label UTF8String], [label length]);
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
