//
//  ViewController.m
//  tableviewEditAdd
//
//  Created by MAX on 16/5/4.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (strong,nonatomic) NSMutableArray *dataArr;
@property int flag;
@end

@implementation ViewController

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i<30; i++) {
        NSString *str = [NSString stringWithFormat:@"产品－%02d",i+1];
        [self.dataArr addObject:str];
    }
    NSLog(@"%@",self.dataArr);
    self.tv.delegate=self;
    self.tv.dataSource = self;
    
}


//删除按钮
- (IBAction)dele:(id)sender {
    self.flag = NO;
    self.tv.editing = !self.tv.editing;
//    if (self.tv.editing) {
//
//    }
    
}
//添加按钮
- (IBAction)edit:(id)sender {
    self.flag = YES;
#pragma mark 1、设置属性
    self.tv.editing = !self.tv.editing;
//    if (self.tv.editing) {
//
//    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

#pragma - tableView 代理方法
#pragma mark 3、编辑状态的操作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag) {
        NSString *str = [NSString stringWithFormat:@"新产品%02d",arc4random()%10];
        [self.dataArr insertObject:str atIndex:indexPath.row];
        [self.tv insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [self.tv deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}

#pragma mark 2、设置可编辑单元格的编辑状态
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag) {
        return UITableViewCellEditingStyleInsert;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
}

#pragma mark 移动单元格
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //1.修改数据;
    //1.1要把原位置的数据取出
    NSString *str = [self.dataArr objectAtIndex:sourceIndexPath.row];
    //1.2要把原来位置的数据删除
    [self.dataArr removeObjectAtIndex:sourceIndexPath.row];
    //1.2将数据插入新的位置
    [self.dataArr insertObject:str atIndex:destinationIndexPath.row];
}
@end
