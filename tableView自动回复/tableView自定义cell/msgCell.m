//
//  msgCell.m
//  tableView自定义cell
//
//  Created by MAX on 16/5/5.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "msgCell.h"

@implementation msgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setMessage:(Message *)message
{
    //设置头像
    UIImageView *imageView = [self.contentView viewWithTag:1];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",arc4random_uniform(8)+1]];
    //设置用户名
    UILabel *nameLabel = [self.contentView viewWithTag:2];
    if ( self.style ==MessageCell_Recive) {
        nameLabel.text = message.userName;
    }
    else
    {
        nameLabel.text = @"wamg";
    }
    
    //设置消息
    UIButton *btn = [self.contentView viewWithTag:3];
    [btn setTitle:message.message forState:UIControlStateNormal];
    //设置时间
    UILabel *timeLabel = [self.contentView viewWithTag:4];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    timeLabel.text = [formatter stringFromDate:message.dataTime];
}

+(id)messageCellWithStyle:(MessageCellType)style;
{
    msgCell *cell = nil;
    if (style == MessageCell_Send) {
        cell = (msgCell *)[[NSBundle mainBundle] loadNibNamed:@"msgCell" owner:self options:nil] [1];
    }
    else{
        cell = (msgCell *)[[NSBundle mainBundle] loadNibNamed:@"msgCell" owner:self options:nil] [0];
        
    }
    return cell;
}
@end
