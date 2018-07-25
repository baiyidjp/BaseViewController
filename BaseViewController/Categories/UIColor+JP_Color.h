//
//  UIColor+Extension.h
//

#import <UIKit/UIKit.h>



#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXColor(s) [UIColor colorWithHexString:s]
// 随机色
#define RGBRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface UIColor (JP_Color)
/**
 iOS十六进制颜色转换为UIColor(默认透明度为1.0)
 带A或者AA的色值 透明度不适用默认的
 
 @param hexString 包括8种格式(RGB,ARGB,RRGGBB,AARRGGBB,#RGB,#ARGB,#RRGGBB,#AARRGGBB)
 @return 颜色
 */
+ (UIColor *)jp_colorWithHexString:(NSString *)hexString;

/**
 iOS十六进制颜色转换为UIColor
 带A或者AA的色值 透明度不适用默认的
 
 @param hexString 包括8种格式(RGB,ARGB,RRGGBB,AARRGGBB,#RGB,#ARGB,#RRGGBB,#AARRGGBB)
 @param alpha 颜色的透明度
 @return 颜色
 */
+ (UIColor *)jp_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
