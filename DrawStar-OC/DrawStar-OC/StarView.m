//
//  StarView.m
//  DrawStar-OC
//
//  Created by 嘴爷 on 2019/6/18.
//  Copyright © 2019 嘴爷. All rights reserved.
//

#import "StarView.h"

@interface StarView()
/** <#description#> */
@property (nonatomic, strong) NSMutableArray<CAShapeLayer*>* shapeLayers;
@end

@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.space = 5;
}

- (void)drawStar:(NSInteger)level count:(NSInteger)count{
    _maxStars = count;
    //    @"★ ★ ★ ★ ★";
    for (NSInteger i = 0; i < count; i++) {
        UIColor* color = i < level ? [UIColor orangeColor] : [UIColor grayColor];
        CGFloat height = self.frame.size.height;
        [self createStarInRect:(CGRectMake((height + self.space) * i, 0, height, height)) color:color index:i];
    }
}

#pragma mark - private method
-(void)createStarInRect:(CGRect)rect color:(UIColor*)color index:(NSInteger)index{
    //    self.backgroundColor = [UIColor purpleColor];
    
#warning 这里注意一下数组长度count是 NSUInteger 类型的，减一就越界了
    if (index > (int)(self.shapeLayers.count) - 1) {//如果缺少layer，就创建
#define DEG(angle) (angle * M_PI / 180.0)
#define P_SIN(radius, angle) (radius * sin(angle * M_PI / 180.0))
#define P_COS(radius, angle) (radius * cos(angle * M_PI / 180.0))
        
        CGFloat r = rect.size.height / 2;//五角星外接圆半径
        //    CGFloat radius_scale = 3 - 4 * sin(DEG(18)) * sin(DEG(18));内外圆半径比
        //    CGFloat inside_radius = out_radius / radius_scale;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGPoint point1 = CGPointMake(0, -r);//顶部的点，开始顺时针，
        CGPoint point2 = CGPointMake(P_COS(r, 18), -P_SIN(r, 18));
        CGPoint point3 = CGPointMake(P_COS(r, 54), P_SIN(r, 54));
        CGPoint point4 = CGPointMake(-P_SIN(r, 36), P_COS(r, 36));
        CGPoint point5 = CGPointMake(-P_COS(r, 18), -P_SIN(r, 18));
        
        //    注意连接的顺序
        [path moveToPoint:point1];
        [path addLineToPoint:point3];
        [path addLineToPoint:point5];
        [path addLineToPoint:point2];
        [path addLineToPoint:point4];
        
        //    [path closePath];//调不调用都可以
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [self.shapeLayers addObject:shapeLayer];
        //    layer.anchorPoint = CGPointMake(0.5, 0.5);动画中心点
        shapeLayer.fillRule = kCAFillRuleNonZero; //kCAFillRuleEvenOdd
        //    从矩形的中心（五角星外接圆的中心，方便坐标计算）开始   有一部分是绘制到了layer外面
        shapeLayer.frame = CGRectMake(rect.origin.x + r, rect.origin.y + r, rect.size.height, rect.size.height);
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = color.CGColor;
        
        [self.layer addSublayer:shapeLayer];
    }else{
        
        CAShapeLayer *shapeLayer = self.shapeLayers[index];
        shapeLayer.fillColor = color.CGColor;
    }
    
}

-(NSMutableArray *)shapeLayers{
    if (!_shapeLayers) {
        _shapeLayers = [NSMutableArray array];
    }
    
    return _shapeLayers;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
