//
//  ViewController.m
//  tableView
//
//  Created by MAX on 16/5/4.
//  Copyright © 2016年 MAX. All rights reserved.
//
#define PERSON_NUM 30
#import "ViewController.h"
#import "person.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(NSMutableArray *)deleArr
{
    if (!_deleArr) {
        _deleArr = [NSMutableArray array];
    }
    return _deleArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i =0; i<PERSON_NUM; i ++) {
        person *p = [[person alloc] init];
        p.name = [NSString stringWithFormat:@"name%d",i+1];
        p.tel = [NSString stringWithFormat:@"1860172%04d",arc4random()%1000];
        p.face = [NSString stringWithFormat:@"%d",arc4random_uniform(9)+1];
        [self.dataArr addObject:p];
    }
    self.tv.dataSource = self;
    self.tv.delegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    person *p = self.dataArr[indexPath.row];
    cell.textLabel.text = p.name;
    cell.imageView.image = [UIImage imageNamed:p.face];
    cell.detailTextLabel.text = p.tel;
    if ([self.deleArr containsObject:p]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

//删除所有行
- (IBAction)cancelBtn:(id)sender {
    [self.deleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArr removeObject:obj];
      
    }];
    [self.deleArr removeAllObjects];
    [self.tv reloadData];
    

//    [self.tv reloadRowsAtIndexPaths:<#(nonnull NSArray<NSIndexPath *> *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];
//    上面的局部刷新方法 只能用在数据更新操作，不能用在添加、删除数据操作。
}
#warning 不用index删除，要用对象删除
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    获取当前cell
    UITableViewCell *cell =  [self.tv cellForRowAtIndexPath:indexPath];

    person *p = self.dataArr[indexPath.row];
    if([self.deleArr containsObject:p])
    {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.deleArr removeObject:p];

    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.deleArr addObject:p];
    }
    
    
}


////点击一行
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    获取当前cell
//    UITableViewCell *cell =  [self.tv cellForRowAtIndexPath:indexPath];
//
//    person *p = self.dataArr[indexPath.row];
//    if(cell.accessoryType == UITableViewCellAccessoryCheckmark)
//    {
//
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        [self.deleArr removeObject:p];
//
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        [self.deleArr addObject:p];
//    }
//
//
//}
////取消上一行
//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//     UITableViewCell *cell =  [self.tv cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryNone;
//}


@end
