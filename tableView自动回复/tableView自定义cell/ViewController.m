//
//  ViewController.m
//  tableView自定义cell
//
//  Created by MAX on 16/5/5.
//  Copyright © 2016年 MAX. All rights reserved.
//
#define MESSAGE_NUM 30
#import "ViewController.h"
#import "Message.h"
#import "msgCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (strong,nonatomic) NSMutableArray *dataArr;

@end
NSString *myName = @"wang";
@implementation ViewController

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr  = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tv.dataSource = self;
    self.tv.delegate = self;
    self.tf.delegate = self;
    self.tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    Message *msg = [[Message alloc] init];
    msg.userName = @"li";
    msg.faceName = [NSString stringWithFormat:@"%d",arc4random_uniform(9)+1];
    msg.message = @"准备开始直播";
    msg.dataTime = [NSDate date];
    [self.dataArr addObject:msg];
}

- (IBAction)sendmessage:(id)sender {
    Message*msg = [[Message alloc] init];
    msg.userName = myName;
    msg.faceName = @"5";
    msg.message = self.tf.text;
    msg.dataTime = [NSDate date];
    
    Message *msg2 = [[Message alloc] init];
    msg2.userName = @"li";
    msg2.faceName = [NSString stringWithFormat:@"%d",arc4random_uniform(9)+1];
    msg2.message = @"ok";
    [self.dataArr addObject:msg];
    [self.dataArr addObject:msg2];
    
    [self.view endEditing:YES];
    [self.tv reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    static NSString *ID;
    Message *msg = self.dataArr[indexPath.row];
    MessageCellType style;
    if ([msg.userName isEqualToString:myName]) {
        ID = @"Cell2";
        style = MessageCell_Send;
    }
    else
    {
        ID = @"Cell";
        style = MessageCell_Recive;
    }
    msgCell *cell = [self.tv dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [msgCell messageCellWithStyle:style];
        cell.style = style;
    }
    [cell setMessage:msg];
    return cell;
}



//键盘return代理方法
#pragma mark - 输入框delegate
//键盘位置操作
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //在键盘出现后，将主视图向上移动
    CGRect textFrame = textField.frame;
    CGFloat keyboardH = 260;
    //计算输入框移动后新的y坐标
    CGFloat newY = self.view.frame.size.height-keyboardH-textFrame.size.height;
    //计算偏移量
    CGFloat offest = textFrame.origin.y - newY;
    if (offest>0) {
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y = -offest;
        self.view.frame = viewFrame;
    }
    //移动整个视图
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    self.view.frame = viewFrame;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
