//
//  msgCell.h
//  tableView自定义cell
//
//  Created by MAX on 16/5/5.
//  Copyright © 2016年 MAX. All rights reserved.
//
typedef enum
{
    MessageCell_Recive,
    MessageCell_Send
}MessageCellType;

#import <UIKit/UIKit.h>
#import "Message.h"
@interface msgCell : UITableViewCell
@property NSInteger style;
-(void)setMessage:(Message *)message;
+(id)messageCellWithStyle:(MessageCellType)style;
@end
