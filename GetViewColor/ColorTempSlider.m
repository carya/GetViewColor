//
//  ColorTempSlider.m
//  Bulb
//
//  Created by MaohuaLiu on 14-9-30.
//  Copyright (c) 2014年 ghzy. All rights reserved.
//

#import "ColorTempSlider.h"

@interface ColorTempSlider ()

@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGFloat innerRadius;
@property (nonatomic) CGFloat outerRadius;
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

@end

@implementation ColorTempSlider

- (id)initWithCenterPoint:(CGPoint)center
              innerRadius:(CGFloat)innerRadius
              outerRadius:(CGFloat)outerRadius
               startAngle:(CGFloat)startAngle
                 endAngle:(CGFloat)endAngle
{
    self = [super initWithCenterPoint:center innerRadius:innerRadius outerRadius:outerRadius startAngle:startAngle endAngle:endAngle];
    if (self) {
        _centerPoint = center;
        _innerRadius = innerRadius;
        _outerRadius = outerRadius;
        _startAngle = startAngle;
        _endAngle = endAngle;
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_color_temp_slider"]]];
        self.clipsToBounds = YES;
    }
    
    return self;
}



#pragma mark - Overrided methods.

- (CAShapeLayer *)layer
{
    return [super layer];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [[self layer] setFillColor:backgroundColor.CGColor];
    
    [[self layer] setStrokeColor:backgroundColor.CGColor];
    
    
    //    borderView = [[UIView alloc] initWithFrame:self.bounds];
    //    [borderView setUserInteractionEnabled:NO];
    //    CAShapeLayer *shapeLayer = [borderView CAShapeLayerFromPoints:[self convertFramePointsToBounds:_arrayTouchPoints]];
    //    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //    [shapeLayer setStrokeColor:[UIColor redColor].CGColor];
    //    [shapeLayer setLineWidth:1.0];
}

-(UIColor *)backgroundColor
{
    return [UIColor colorWithCGColor:[[self layer] fillColor]];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGPathContainsPoint([[self layer] path], NULL, point, ([[self layer] fillRule] == kCAFillRuleEvenOdd)))
    {
        return [super hitTest:point withEvent:event];
    }
    else
    {
        return nil;
    }
    
}

#pragma mark -
#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchedBegan");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGVector previousOffsetToCenter = [self point:previousLocation anotherPoint:centerPoint];
    float previousRadian = [self toRadian:previousOffsetToCenter];
    
    CGPoint currentLocation = [touch locationInView:self];
    CGVector currentOffsetToCenter = [self point:currentLocation anotherPoint:centerPoint];
    float currentRadian = [self toRadian:currentOffsetToCenter];
    
    float changedRadian = currentRadian - previousRadian;
    [self setRotate:changedRadian];
    
    [self sliderValueChanged];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches cancelled.");
    _touchEventEndBlock();
}

- (void)sliderValueChanged
{
//    CGPoint point = CGPointMake(CGRectGetWidth(self.bounds)/2, 3);
//    UIColor *color = [self colorOfPoint:point];
//    NSLog(@"color of point.x: %f, y: %f", point.x, point.y);
    _valueChanged(nil);
}

- (UIColor *)colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [[self layer] renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

- (CGVector)point:(CGPoint)onePoint anotherPoint:(CGPoint)anotherPoint
{
    return CGVectorMake(onePoint.x - anotherPoint.x, onePoint.y - anotherPoint.y);
}

- (float)toRadian:(CGVector)vector
{
    return atan2f(vector.dy, vector.dx);
}

-(void)setRotate:(float)radian
{
    CGAffineTransform transform = self.transform;
    transform = CGAffineTransformRotate(transform, radian);
    self.transform = transform;
}
@end
