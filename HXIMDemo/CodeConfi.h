//
//  CodeConfi.h
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#ifndef CodeConfi_h
#define CodeConfi_h


#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RECT(x,y,width,height) CGRectMake(x, y, width, height)

#define weakself(x) autoreleasepool{} __weak typeof(x) weak##x=x

// ----------🔽

#define ENABLE_DEBUG

#ifdef ENABLE_DEBUG

#define DebugLog(format, args...) \
NSLog(@"%s, line %d: " format "\n", \
__func__, __LINE__, ## args);

#else

#define DebugLog(format,args...) do {} while(0)


#endif

// -----------🔼

#endif /* CodeConfi_h */
