//
//  Header.h
//  BrokenLine
//
//  Created by 君未央 on 2017/5/16.
//  Copyright © 2017年 ZDQ. All rights reserved.
//

#ifndef Header_h
#define Header_h


#endif /* Header_h */


#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
