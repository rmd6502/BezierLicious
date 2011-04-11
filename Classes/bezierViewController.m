//
//  bezierViewController.m
//  bezier
//
//  Created by Robert Diamond on 4/11/11.
//  Copyright 2011 none. All rights reserved.
//

#import "bezierViewController.h"
#import "BezierView.h"
#import <math.h>
#import <objc/objc.h>

double dist(CGPoint a, CGPoint b) {
	double dx = a.x - b.x;
	double dy = a.y - b.y;
	return sqrt(dx*dx + dy*dy);
}

@implementation bezierViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	BezierView *bv = (BezierView *)self.view;
	bv.b = CGPointMake(10, 10);
	bv.a = CGPointMake(200, 30);
	bv.c = CGPointMake(180, 300);
	bv.d = CGPointMake(30, 220);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([touches count] != 1) return;
	CGPoint t = [(UITouch *)[touches anyObject] locationInView:self.view];
	BezierView *bv = (BezierView *)self.view;
	
	// Yes, this is ugly.  It's prototype, so I don't care
	double adist = dist(t,bv.a);
	double bdist = dist(t,bv.b);
	double cdist = dist(t,bv.c);
	double ddist = dist(t,bv.d);
	double mindist = fmin(fmin(adist, bdist),fmin(cdist,ddist));
	if (mindist == adist) {
		changer = @selector(setA:);
	} else if (mindist == bdist) {
		changer = @selector(setB:);
	} else if (mindist == cdist) {
		changer = @selector(setC:);
	} else {
		changer = @selector(setD:);
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([touches count] != 1) return;
	CGPoint t = [(UITouch *)[touches anyObject] locationInView:self.view];
	objc_msgSend(self.view, changer, t);
	[self.view setNeedsDisplay];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
