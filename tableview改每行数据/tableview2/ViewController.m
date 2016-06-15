//
//  ViewController.m
//  tableview2
//
//  Created by MAX on 16/5/3.
//  Copyright © 2016年 MAX. All rights reserved.
//
#define PESON_NUM 30
#import "ViewController.h"
#import "Person.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (strong,nonatomic) NSMutableArray *dataArr;
@property (strong,nonatomic) UITableViewCell *Cell;

@end

@implementation ViewController

-(NSMutableArray *)dataArr
{
    if (!_dataArr  ) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tv.dataSource = self;
    self.tv.delegate = self;
    
    for (int i = 0; i<PESON_NUM; i++) {
        Person *p  = [[Person alloc] init];
//        self.dataArr = [NSMutableArray array];
        p.name = [NSString stringWithFormat:@"name%d",i];
//        随机四位
        p.tel = [NSString stringWithFormat:@"1861010%04d",arc4random()%1000];
//        9个数随机其中一个数
        p.face = [NSString stringWithFormat:@"%d",arc4random_uniform(9)+1];
        [self.dataArr addObject:p ];
        
    }
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
    self.Cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!self.Cell) {
        self.Cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    Person *p = self.dataArr [indexPath.row];
    self.Cell.textLabel.text = [NSString stringWithFormat:@"%@",p.name];
    self.Cell.detailTextLabel.text = p.tel;
    self.Cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",p.face]];
    self.Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return self.Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"被选中" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
//    设置alertview显示输入框
    alerView.alertViewStyle = UIAlertViewStylePlainTextInput;
    Person *p = self.dataArr[indexPath.row];
    [alerView textFieldAtIndex:0].text = p.name;
    alerView.tag = indexPath.row;
    [alerView show];
}

//取消cell点击时候调用的方法
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//获取某个cell
    self.Cell = [self.tv cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
 

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
//        获取输入框的内容
        NSString *newName = [alertView textFieldAtIndex:0].text;
        Person *p = self.dataArr[alertView.tag];
        p.name = newName;
//       刷新全部数据
//        [self.tv reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:alertView.tag inSection:0];
       
//        局部刷新
        [self.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    
}
@end
