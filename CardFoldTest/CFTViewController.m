//
//  CFTViewController.m
//  CardFoldTest
//
//  Created by Aqeel Gunja on 8/14/12.
//  Copyright (c) 2012 Aqeel Gunja. All rights reserved.
//

#import "CFTViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface CFTViewController ()

@property (nonatomic, strong) CATransformLayer *baseLayer;
@property (nonatomic, strong) CATransformLayer *middleBaseLayer;

@property (nonatomic, strong) CALayer *leftLayer;
@property (nonatomic, strong) CALayer *middleLayer;
@property (nonatomic, strong) CALayer *rightLayer;

@end

@implementation CFTViewController
{
    BOOL isThreeDee;
    CGFloat _progress;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        _progress = 1.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
	[self.view addGestureRecognizer:pan];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	[self.view addGestureRecognizer:tap];
    
	UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
	[self.view addGestureRecognizer:pinch];
    
	self.view.backgroundColor = [UIColor blackColor];    
    
    CGRect bounds = self.view.bounds;
    
    CGRect layerBounds = CGRectMake(0, 0, 200, 600);
    
    self.baseLayer = [CATransformLayer layer];
    self.baseLayer.bounds = bounds;
    self.baseLayer.anchorPoint = CGPointZero;
    self.baseLayer.position = CGPointMake(200, 400);
//    self.baseLayer.borderWidth = 1.0;
//    self.baseLayer.borderColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:self.baseLayer];
    
    CALayer *squareLayer = [CALayer layer];
    squareLayer.frame = CGRectMake(0, 0, 100, 100);
    squareLayer.zPosition = 100.0;
    squareLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.baseLayer addSublayer:squareLayer];
    
    CALayer *leftLayer = [CALayer layer];
    leftLayer.backgroundColor = [UIColor redColor].CGColor;
    leftLayer.frame = layerBounds;
    leftLayer.position = CGPointZero;
    self.leftLayer = leftLayer;
    [self.baseLayer addSublayer:leftLayer];
    
    CATransformLayer *middleBaseLayer = [CATransformLayer layer];
    middleBaseLayer.bounds = layerBounds;
    middleBaseLayer.anchorPoint = CGPointMake(0.0, 0.5);
    middleBaseLayer.position = CGPointMake(100, 0);
//    middleBaseLayer.borderWidth = 1.0;
//    middleBaseLayer.borderColor = [UIColor orangeColor].CGColor;
    self.middleBaseLayer = middleBaseLayer;
    [self.baseLayer addSublayer:middleBaseLayer];
    
    CATextLayer *middleLayer = [CATextLayer layer];
    middleLayer.backgroundColor = [UIColor blueColor].CGColor;
    middleLayer.frame = layerBounds;
    middleLayer.anchorPoint = CGPointZero;
    middleLayer.position = CGPointZero;
    self.middleLayer = middleLayer;
    middleLayer.string = @"1";
    middleLayer.fontSize = 36.0;
    [self.middleBaseLayer addSublayer:middleLayer];
    
    CALayer *rightLayer = [CALayer layer];
    rightLayer.backgroundColor = [UIColor greenColor].CGColor;
    rightLayer.frame = layerBounds;
    rightLayer.anchorPoint = CGPointMake(0.0, 0.5);
    rightLayer.position = CGPointMake(200, 300);
    self.rightLayer = rightLayer;
    [self.middleBaseLayer addSublayer:rightLayer];
    
	CATransform3D initialTransform = self.baseLayer.sublayerTransform;
	initialTransform.m34 = 1.0 / -1200;
	self.baseLayer.sublayerTransform = initialTransform;
    [self.baseLayer insertSublayer:leftLayer above:middleBaseLayer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    CATransformLayer *baseLayer = self.baseLayer;
	if (gesture.state == UIGestureRecognizerStateChanged)
	{
		CGPoint displacement = [gesture translationInView:self.view.superview];
		CATransform3D currentTransform = baseLayer.sublayerTransform;
		
		if (displacement.x==0 && displacement.y==0)
		{
			// no rotation, nothing to do
			return;
		}
		
		CGFloat totalRotation = sqrt(displacement.x * displacement.x + displacement.y * displacement.y) * M_PI / 180.0;
		CGFloat xRotationFactor = displacement.x/totalRotation;
		CGFloat yRotationFactor = displacement.y/totalRotation;
		
		
		if (isThreeDee)
		{
			currentTransform = CATransform3DTranslate(currentTransform, 0, 0, 50);
		}
		
		CATransform3D rotationalTransform = CATransform3DRotate(currentTransform, totalRotation,
                                                                (xRotationFactor * currentTransform.m12 - yRotationFactor * currentTransform.m11),
                                                                (xRotationFactor * currentTransform.m22 - yRotationFactor * currentTransform.m21),
                                                                (xRotationFactor * currentTransform.m32 - yRotationFactor * currentTransform.m31));
		
		if (isThreeDee)
		{
			rotationalTransform = CATransform3DTranslate(rotationalTransform, 0, 0, -50);
		}
		
		[CATransaction setAnimationDuration:0];
		
		baseLayer.sublayerTransform = rotationalTransform;
		
		
		[gesture setTranslation:CGPointZero inView:self.view];
	}
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
	isThreeDee = !isThreeDee;
	
	if (isThreeDee)
	{
//		greenLayer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
//		blueLayer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
//		yellowLayer.transform = CATransform3DMakeRotation(-M_PI_2, 1, 0, 0);
//		purpleLayer.transform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
//		magentaLayer.transform = CATransform3DMakeRotation(0.8*-M_PI_2, 0, 1, 0);
        
        self.middleBaseLayer.transform = CATransform3DMakeRotation(M_PI / 1.00001, 0, 1, 0);        
        self.rightLayer.transform = CATransform3DMakeRotation(-M_PI/1.00001, 0, 1, 0);
        
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        transformAnimation.duration = 2.0;
        transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        transformAnimation.toValue = [NSValue valueWithCATransform3D:self.middleBaseLayer.transform];
        [self.middleBaseLayer addAnimation:transformAnimation forKey:@"transform"];
        
        CABasicAnimation *rightAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        rightAnimation.duration = 1.5;
        rightAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        rightAnimation.toValue = [NSValue valueWithCATransform3D:self.rightLayer.transform];
        [self.rightLayer addAnimation:rightAnimation forKey:@"transform"];
	}
	else
	{
        self.middleBaseLayer.transform = CATransform3DIdentity;
        self.rightLayer.transform = CATransform3DIdentity;
	}
}

- (void)updateTransformsWithProgress:(CGFloat)progress
{
    CGFloat angle = (1-progress) * M_PI;
    self.middleBaseLayer.transform = CATransform3DMakeRotation(angle / 1.00001, 0, 1, 0);
    self.rightLayer.transform = CATransform3DMakeRotation(-angle/1.00001, 0, 1, 0);
    [CATransaction setAnimationDuration:0.0];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    CGFloat factor = 0.1;
	if (pinch.state == UIGestureRecognizerStateChanged)
	{
		//	currentTransform = baseLayer.sublayerTransform;
        if (_progress <= 1.0 || _progress >= 0.0) {
            if (pinch.scale < 1.0) {
                factor = -factor * (1/pinch.scale);
            }
            else
            {
                factor *= factor * pinch.scale;
            }
            _progress += factor * pinch.scale;
            if (_progress < 0) {
                _progress = 0;
            }
            if (_progress > 1) {
                _progress = 1;
            }
        }
        [self updateTransformsWithProgress:_progress];
		NSLog(@"%f %f", pinch.scale,factor);
	}
    pinch.scale = 1.0;
}

@end
