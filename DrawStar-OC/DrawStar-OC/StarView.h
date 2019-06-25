//
//  StarView.h
//  DrawStar-OC
//
//  Created by 嘴爷 on 2019/6/18.
//  Copyright © 2019 嘴爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StarView : UIView

/** <#description#> */
@property (nonatomic, readonly) NSInteger maxStars;

/** <#description#> */
@property (nonatomic, readonly) NSInteger level;

/** 星星的间距 */
@property (nonatomic) CGFloat space;

/** 是否可选择 默认NO */
@property (nonatomic) BOOL canSelect;

- (void)drawStar:(NSInteger)level count:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
