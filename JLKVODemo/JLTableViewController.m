//
//  JLTableViewController.m
//  JLKVODemo
//
//  Created by Julian Song on 17/3/2.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import "JLTableViewController.h"
#import "JLKVO.h"
static void*JLKVOName = &JLKVOName;
static void*JLKVOPhone = &JLKVOPhone;
static void*JLKVOTitle = &JLKVOTitle;
static void*JLKVORole = &JLKVORole;

@interface JLTableViewController ()
@property(nonnull,strong)JLKVO *kvoObject;
@end

@implementation JLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kvoObject = [[JLKVO alloc] init];
    self.kvoObject.role = [NSMutableArray arrayWithArray:@[@"aaa",@"bbb"]];
//    self.kvoObject.phone = @"start";
    [self.kvoObject addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(name))
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:JLKVOName];
    [self.kvoObject addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(phone))
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionInitial//加入此参数在本方法调用时会立即触发observeValueForKeyPath方法
                        context:JLKVOPhone];
    
    [self.kvoObject addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(title))
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionPrior//加入此参数会在willChangeValueForKey被触发时候立即触发observeValueForKeyPath方法
                        context:JLKVOTitle];
    [self.kvoObject addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(role))
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:JLKVORole];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == JLKVOName) {
        NSLog(@"\n%@\n%@",keyPath,change);
    }
    else if (context == JLKVOPhone)
    {
        NSLog(@"\n%@\n%@",keyPath,change);
    }
    else if (context == JLKVORole)
    {
        NSLog(@"\n%@\n%@",keyPath,change);
    }
    else if (context == JLKVOTitle)
    {
        NSLog(@"\n%@\n%@",keyPath,change);
    }
    else
    {
        //如果此方法传递到NSObject 则会抛出NSInternalInconsistencyException。
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.kvoObject.name = [[NSDate date] description];
    }
    if (indexPath.row == 1) {
        self.kvoObject.phone = [[NSDate date] description];
    }
    if (indexPath.row == 2) {
        self.kvoObject.title = [[NSDate date] description];
    }
    if (indexPath.row == 3) {
        NSMutableArray *role = [self.kvoObject mutableArrayValueForKey:@"role"];
        [role addObjectsFromArray:@[@"cc",@"dd",@"ee"]];
    }
}
@end
