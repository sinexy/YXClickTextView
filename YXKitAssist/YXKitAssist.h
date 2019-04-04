//
//  YXKitAssist.h
//  YXKit
//
//  Created by yunxin bai on 2017/8/18.
//  Copyright © 2017 yunxin bai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXKitAssist : NSObject

#pragma mark - UIView

/** NSNumber */
- (YXKitAssist*(^)(id))tag;
/** NSValue */
- (YXKitAssist*(^)(id))frame;
/** NSNumber */
- (YXKitAssist*(^)(id))alpha;
/** UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (YXKitAssist*(^)(id))bgColor;
/** UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (YXKitAssist*(^)(id))bdColor;
/** NSNumber */
- (YXKitAssist*(^)(id))bdWidth;
/** NSNumber */
- (YXKitAssist*(^)(id))cnRadius;
/** @(YES) or @(NO) */
- (YXKitAssist*(^)(id))mtBounds;

#pragma mark - UILabel & UITextView & UITextField

/** NSString */
- (YXKitAssist*(^)(id))text;
/** UIFont */
- (YXKitAssist*(^)(id))font;
/** UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (YXKitAssist*(^)(id))color;
/** NSNumber: @0,@1,@2 */
- (YXKitAssist*(^)(id))align;
/** substring: NSString, value:color or font. */
- (YXKitAssist*(^)(id,id))attributedSubstring;
/** substring: NSString, value:color or font, range: NSValue. */
- (YXKitAssist*(^)(id,id,id))attributedSubstringInRange;

#pragma mark - UILabel

/** NSNumber(NSInteger) */
- (YXKitAssist*(^)(id))lines;
/** adjustsFontSizeToFitWidth: @(YES) or @(NO) */
- (YXKitAssist*(^)(id))adjust;
/** NSNumber(CGFloat) */
- (YXKitAssist*(^)(id))lineSpace;
/** NSNumber(CGFloat), 0 means no max width limit. */
- (YXKitAssist*(^)(id))autoWidth;
/** NSNumber(CGFloat), 0 means no max height limit. */
- (YXKitAssist*(^)(id))autoHeight;

#pragma mark - UIButton

/** title: NSString, state: NSNumber */
- (YXKitAssist*(^)(id,id))titleForState;
/** color: UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) , state: NSNumber */
- (YXKitAssist*(^)(id,id))colorForState;
/** image: UIImage, state: NSNumber */
- (YXKitAssist*(^)(id,id))imageForState;
/** bgImage: UIImage, state: NSNumber */
- (YXKitAssist*(^)(id,id))bgImageForState;
/** lineSpace: NSNumber, state: NSNumber */
- (YXKitAssist*(^)(id,id))lineSpaceForState;
/** space: NSNumber */
- (YXKitAssist*(^)(id))imageUpTitleDown;
/** space: NSNumber */
- (YXKitAssist*(^)(id))imageDownTitleUp;
/** space: NSNumber */
- (YXKitAssist*(^)(id))imageRightTitleLeft;
/** space: NSNumber */
- (YXKitAssist*(^)(id))imageLeftTitleRight;
/** all center */
- (YXKitAssist*(^)(void))imageCenterTitleCenter;
/** substring: NSString, value:color or font, state: NSNumber */
- (YXKitAssist*(^)(id,id,id))attributedSubstringForState;
/** substring: NSString, value:color or font, range: NSValue, state: NSNumber */
- (YXKitAssist*(^)(id,id,id,id))attributedSubstringInRangeForState;

#pragma mark - UIImageView

/** image: UIImage, NSString */
- (YXKitAssist*(^)(id))image;
/** image: UIImage,NSString, color: UIColor */
- (YXKitAssist*(^)(id,id))imageForTintColor;


#pragma mark - UITextField

/** borderStyle, NSNumber: @1,@2,@3,@4 */
- (YXKitAssist*(^)(id))bdStyle;
/** placeholder, NSString */
- (YXKitAssist*(^)(id))pHolder;
/** placeholder color, UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (YXKitAssist*(^)(id))pHColor;
/** placeholder font, UIFont */
- (YXKitAssist*(^)(id))pHFont;
/** clearButtonMode, NSNumber: @1,@2,@3,@4 */
- (YXKitAssist*(^)(id))cbMode;
/** leftViewMode, NSNumber: @1,@2,@3,@4 */
- (YXKitAssist*(^)(id))lvMode;
/** rightViewMode, NSNumber: @1,@2,@3,@4 */
- (YXKitAssist*(^)(id))rvMode;
/** leftView, UIView */
- (YXKitAssist*(^)(id))lfView;
/** rightView, UIView */
- (YXKitAssist*(^)(id))rtView;
/** secureTextEntry, BOOL: @YES, @NO */
- (YXKitAssist*(^)(id))secure;
@end

@interface UIView (YXKitAssist)

@property (nonatomic, strong) YXKitAssist *yxkit_assist;

@end

@interface UIColor (YXKitAssist)

+ (UIColor *)kitAssist:(id)color;

@end
