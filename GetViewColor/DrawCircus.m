//
//  DrawCircus.m
//  Bulb
//
//  Created by MaohuaLiu on 14-9-30.
//  Copyright (c) 2014年 ghzy. All rights reserved.
//

#import "DrawCircus.h"

@implementation DrawCircus

+ (CGFloat)transToRadian:(CGFloat)angle
{
    return angle * M_PI / 180;
}

/*
 * parseToX 根据角度，半径计算X坐标
 * @radius CGFloat 半径
 * @angle  CGFloat 角度
 */
+ (CGFloat)parseToX:(CGFloat)radius Angle:(CGFloat)angle
{
    CGFloat tempRadian = [self transToRadian:angle];
    return radius*cos(tempRadian);
}

/*
 * parseToY 根据角度，半径计算Y坐标
 * @radius CGFloat 半径
 * @angle  CGFloat 角度
 */
+ (CGFloat)parseToY:(CGFloat)radius Angle:(CGFloat)angle
{
    CGFloat tempRadian = [self transToRadian:angle];
    return radius*sin(tempRadian);
}

+ (CGFloat)parseToX:(CGFloat)radius radian:(CGFloat)radian
{
    return radius*cos(radian);
}

/*
 * parseToY 根据角度，半径计算Y坐标
 * @radius CGFloat 半径
 * @radian  CGFloat 弧度
 */
+ (CGFloat)parseToY:(CGFloat)radius radian:(CGFloat)radian
{
    return radius*sin(radian);
}

+ (CGPathRef)circusPathWithCenterPoint:(CGPoint)centerPoint
                                   innerRadius:(CGFloat)innerRadius
                                   outerRadius:(CGFloat)outerRadius
                                    startAngle:(CGFloat)startAngle
                                      endAngle:(CGFloat)endAngle
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(centerPoint.x + [self parseToX:innerRadius Angle:startAngle], centerPoint.y + [self parseToY:innerRadius Angle:startAngle]);
    NSLog(@"startPoint x: %f, y: %f", startPoint.x, startPoint.y);
    
    [path moveToPoint:startPoint];
    
    [path addArcWithCenter:centerPoint radius:innerRadius startAngle:[self transToRadian:startAngle] endAngle:[self transToRadian:endAngle] clockwise:YES];
    
    CGPoint outerPoint = CGPointMake(centerPoint.x + [self parseToX:outerRadius Angle:endAngle], centerPoint.y + [self parseToY:outerRadius Angle:endAngle]);
    NSLog(@"outerPoint x = %f, y = %f", [self parseToX:outerRadius Angle:endAngle], [self parseToY:outerRadius Angle:endAngle]);
    [path addLineToPoint:outerPoint];
    [path addArcWithCenter:centerPoint radius:outerRadius startAngle:[self transToRadian:endAngle] endAngle:[self transToRadian:startAngle] clockwise:NO];
    [path addLineToPoint:startPoint];
    [path closePath];
    
    return CGPathCreateCopy(path.CGPath);
}

- (id)initWithCenterPoint:(CGPoint)center
              innerRadius:(CGFloat)innerRadius
              outerRadius:(CGFloat)outerRadius
               startAngle:(CGFloat)startAngle
                 endAngle:(CGFloat)endAngle
{
    CGPathRef path = [DrawCircus circusPathWithCenterPoint:center innerRadius:innerRadius outerRadius:outerRadius startAngle:startAngle endAngle:endAngle];
    self = [super initWithFrame:CGPathGetBoundingBox(path)];
    if (self) {
        [self setUserInteractionEnabled:YES];
        CGAffineTransform t = CGAffineTransformMakeTranslation(-CGRectGetMinX(self.frame), -CGRectGetMinY(self.frame));
        [[self layer] setPath:CGPathCreateCopyByTransformingPath(path, &t)];
        [[self layer] setFillMode:kCAFillRuleNonZero];
//        [self setBackgroundColor:[UIColor whiteColor]];
    }
    
    return self;
}

#pragma mark - Overrided methods.

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (CAShapeLayer *)layer
{
    return (CAShapeLayer*)[super layer];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [[self layer] setFillColor:backgroundColor.CGColor];
    [[self layer] setStrokeColor:backgroundColor.CGColor];
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


@end
