//
//  CFTViewController.m
//  CardFoldTest
//
//  Created by Aqeel Gunja on 8/14/12.
//  Copyright (c) 2012 Aqeel Gunja. All rights reserved.
//

#import "CFTViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "ABPPamphletView.h"
#import "ABPTransformView.h"

@interface CFTViewController ()

@property (nonatomic, strong) CALayer *baseLayer;
@property (nonatomic, strong) CATransformLayer *middleBaseLayer;

@property (nonatomic, strong) CALayer *leftLayer;
@property (nonatomic, strong) CALayer *middleLayer;
@property (nonatomic, strong) CALayer *rightLayer;

@property (nonatomic, strong) ABPPamphletView *pamphletView;

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

- (void)createPamphletLayer
{
    CGRect bounds = self.view.bounds;
    
    CGRect layerBounds = CGRectMake(0, 0, 200, 600);
    
    UIView *baseView = [[ABPTransformView alloc] initWithFrame:layerBounds];
    self.baseLayer = baseView.layer;//[CATransformLayer layer];
    self.baseLayer.bounds = layerBounds;
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
    
    UIView *leftView = [[UIView alloc] initWithFrame:layerBounds];
    CALayer *leftLayer = leftView.layer;//[CALayer layer];
    leftLayer.backgroundColor = [UIColor redColor].CGColor;
    leftLayer.frame = layerBounds;
    leftLayer.position = CGPointZero;
    self.leftLayer = leftLayer;
    [self.baseLayer addSublayer:leftLayer];
    
    //    CALayer *leftBackLayer = [CALayer layer];
    //    leftBackLayer.backgroundColor = [UIColor yellowColor].CGColor;
    //    leftBackLayer.frame = layerBounds;
    //    leftBackLayer.position = CGPointZero;
    //    leftBackLayer.anchorPoint = CGPointMake(1.0,0.5);
    //    leftBackLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    //    leftBackLayer.doubleSided = YES;
    //    [self.leftLayer addSublayer:leftBackLayer];
    
    ABPTransformView *middleBaseView = [[ABPTransformView alloc] initWithFrame:layerBounds];
    CATransformLayer *middleBaseLayer = (CATransformLayer *)middleBaseView.layer;//[CATransformLayer layer];
    middleBaseLayer.bounds = layerBounds;
    middleBaseLayer.anchorPoint = CGPointMake(0.0, 0.5);
    middleBaseLayer.position = CGPointMake(100, 0);
    //    middleBaseLayer.borderWidth = 1.0;
    //    middleBaseLayer.borderColor = [UIColor orangeColor].CGColor;
    self.middleBaseLayer = middleBaseLayer;
    [self.baseLayer addSublayer:middleBaseLayer];
    
    UIView *middleView = [[UIView alloc] initWithFrame:layerBounds];
    CALayer *middleLayer = middleView.layer;//[CATextLayer layer];
    middleLayer.backgroundColor = [UIColor blueColor].CGColor;
    middleLayer.frame = layerBounds;
    middleLayer.anchorPoint = CGPointZero;
    middleLayer.position = CGPointZero;
    self.middleLayer = middleLayer;
//    middleLayer.string = @"1";
//    middleLayer.fontSize = 36.0;
    [self.middleBaseLayer addSublayer:middleLayer];
    
    UIView *rightView = [[UIView alloc] initWithFrame:layerBounds];
    CALayer *rightLayer = rightView.layer;//[CALayer layer];
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
    [self.middleBaseLayer insertSublayer:rightLayer above:middleLayer];
}

- (void)logicalPamphletLayer
{
    CGRect baseLayerBounds = CGRectMake(0, 0, 600, 600);
    CGRect layerFrame = CGRectMake(0, 0, 200, 600);
    
    CALayer *baseLayer = [CALayer layer];
    baseLayer.bounds = baseLayerBounds;
    CGRect baseFrame = {
        .origin = CGPointMake(100, 100),
        .size = baseLayerBounds.size
    };
    baseLayer.frame = baseFrame;
    self.baseLayer = baseLayer;
    [self.view.layer addSublayer:self.baseLayer];
    
    CALayer *leftLayer = [CALayer layer];
    leftLayer.frame = layerFrame;
    leftLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.leftLayer = leftLayer;
    [self.baseLayer addSublayer:leftLayer];
    
    CATransformLayer *middleBaseLayer = [CATransformLayer layer];
    middleBaseLayer.anchorPoint = CGPointMake(0.0, 0.5);
    middleBaseLayer.frame = CGRectMake(200, 0, 400, 600);    
    self.middleBaseLayer = middleBaseLayer;
    [self.baseLayer addSublayer:middleBaseLayer];
    
    CALayer *middleLayer = [CALayer layer];
    middleLayer.frame = CGRectMake(0, 0, 200, 600);
    middleLayer.backgroundColor = [UIColor redColor].CGColor;
    self.middleLayer = middleLayer;
    [self.middleBaseLayer addSublayer:middleLayer];
    
    CALayer *rightLayer = [CALayer layer];
    rightLayer.anchorPoint = CGPointMake(0.0, 0.5);    
    rightLayer.frame = CGRectMake(200, 0, 200, 600);
    rightLayer.backgroundColor = [UIColor greenColor].CGColor;
    self.rightLayer = rightLayer;
    [self.middleBaseLayer addSublayer:rightLayer];
    
	CATransform3D initialTransform = self.baseLayer.sublayerTransform;
	initialTransform.m34 = 1.0 / -1200;
	self.baseLayer.sublayerTransform = initialTransform;
    [self.baseLayer insertSublayer:leftLayer above:middleBaseLayer];
    [self.middleBaseLayer insertSublayer:rightLayer above:middleLayer];
}

- (void)setupPamphletView
{
    CGRect frame = CGRectMake(0, 0, 200, 600);
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 600)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 60, 30);
    [leftView addSubview:button];
    leftView.backgroundColor = [UIColor blueColor];
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 600)];
    middleView.backgroundColor = [UIColor redColor];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 600)];
    rightView.backgroundColor = [UIColor greenColor];
    
    ABPPamphletView *pamphletView = [[ABPPamphletView alloc] init];
    pamphletView.leftView = leftView;
    pamphletView.middleView = middleView;
    pamphletView.rightView = rightView;
    [pamphletView sizeToFit];
    pamphletView.center = CGPointMake(1024/2, 768/2);
    //[pamphletView layoutIfNeeded];
    self.pamphletView = pamphletView;
    
    [self.view addSubview:pamphletView];
    
    self.baseLayer = pamphletView.layer;
    self.leftLayer = leftView.layer;
    self.middleBaseLayer = (CATransformLayer *)pamphletView.middleBaseView.layer;
    self.middleLayer = middleView.layer;
    self.rightLayer = rightView.layer;
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
    
    //[self logicalPamphletLayer];
    //[self createPamphletLayer];
    [self setupPamphletView];
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
    [self.pamphletView setOpen:![self.pamphletView isOpen]];
//	isThreeDee = !isThreeDee;
//	
//	if (isThreeDee)
//	{
////		greenLayer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
////		blueLayer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
////		yellowLayer.transform = CATransform3DMakeRotation(-M_PI_2, 1, 0, 0);
////		purpleLayer.transform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
////		magentaLayer.transform = CATransform3DMakeRotation(0.8*-M_PI_2, 0, 1, 0);
//
//        self.middleBaseLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
//        self.rightLayer.transform = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
//        
//        CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//        transformAnimation.duration = 2.0;
////        transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//
//        CATransform3D midTransform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
//        transformAnimation.values = @[ [NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:midTransform], [NSValue valueWithCATransform3D:self.middleBaseLayer.transform]];
//        
////        transformAnimation.toValue = [NSValue valueWithCATransform3D:self.middleBaseLayer.transform];
//        [self.middleBaseLayer addAnimation:transformAnimation forKey:@"transform"];
//        
//        CAKeyframeAnimation *rightAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//        rightAnimation.duration = 1.5;
////        rightAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//        
//        midTransform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
// 
////        rightAnimation.toValue = [NSValue valueWithCATransform3D:self.rightLayer.transform];
//        [self.rightLayer addAnimation:rightAnimation forKey:@"transform"];
//	}
//	else
//	{
//        self.middleBaseLayer.transform = CATransform3DIdentity;
//        self.rightLayer.transform = CATransform3DIdentity;
//        self.baseLayer.transform = CATransform3DIdentity;    
//	}
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
