//
//  Message.h
//  tableView自定义cell
//
//  Created by MAX on 16/5/5.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (strong,nonatomic)NSString *userName;
@property (strong,nonatomic)NSString *faceName;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSDate  *dataTime;
@end
