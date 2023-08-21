//
//  XYDefineMacro.h
//  Pods
//
//  Created by XXYY on 2021/3/15.
//

#ifndef XYDefineMacro_h
#define XYDefineMacro_h

#define APP_SAFE_BOTTOM  (APP_IS_IPHONE_X?34:0)
#define APP_IS_IPHONE_X  [UIDevice isIPhoneNotchScreen]
#define APP_NAV_BAR_Height (APP_IS_IPHONE_X?88:64)
#define APP_STA_BAR_Height (APP_IS_IPHONE_X?44:20)


#define XYS(x) round(x * MIN(UIScreen.screenWidth, 414)/ 375.0)  //最大用414 来做比例伸缩 否则在pad 上会特别大
#define XYSV(x) round(x * MIN(UIScreen.screenHeight, 896)/ 667)  //最大用896 iphoneX MAX 来做比例伸缩

#endif /* XYDefineMacro_h */
