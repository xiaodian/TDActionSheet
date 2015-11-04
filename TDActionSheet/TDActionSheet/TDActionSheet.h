//
//  TDActionSheet.h
//  TDActionSheet
//
//  Created by Su Jiandong on 15/11/4.
//  Copyright © 2015年 Su Jiandong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TDActionBlock) (NSInteger buttonIndex);

@interface TDActionSheet : UIView

- (instancetype)initWithTitles:(NSArray *)titles callBack:(TDActionBlock )callBack;

- (void)show;

@end
