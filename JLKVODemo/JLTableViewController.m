//
//  JLTableViewController.m
//  JLKVODemo
//
//  Created by Julian Song on 17/3/2.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import "JLTableViewController.h"
#import "JLKVO.h"
#import <objc/runtime.h>
static void*JLKVOName = &JLKVOName;
static void*JLKVOPhone = &JLKVOPhone;
static void*JLKVOTitle = &JLKVOTitle;
static void*JLKVORole = &JLKVORole;
static void*JLKVOCV = &JLKVOCV;
static void*JLKVOInnerVal = &JLKVOInnerVal;

@interface JLTableViewController ()
@property(nonnull,strong)JLKVO *kvoObject;
@end

@implementation JLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kvoObject = [[JLKVO alloc] init];
    self.kvoObject.role = [NSMutableArray arrayWithArray:@[@"aaa",@"bbb"]];
    NSLog(@"class of kvoObject before regist:%@",object_getClass(self.kvoObject));
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

    [self.kvoObject addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(cv))
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:JLKVOCV];
    [self.kvoObject addObserver:self
                     forKeyPath:@"_innerValue"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:JLKVOInnerVal];
    /*
     对象被注册为kvo后isa会被重写，此处kvoObject的类会由JLKVO变为NSKVONotifying_JLKVO。
     ios7之后isa属性不在使用。由object_getClass 和object_setClass 对isa属性进行操作
     */
    NSLog(@"class of kvoObject after regist:%@",object_getClass(self.kvoObject));
    
    self.kvoObject.access = [NSMutableArray arrayWithArray:@[@(2),@(3),@(5),@(2),@(5)]];
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
    else if (context == JLKVOCV)
    {
        NSLog(@"\n%@\n%@",keyPath,change);
    }
    else if (context == JLKVOInnerVal)
    {
        NSLog(@"成员变量\n%@\n%@",keyPath,change);
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.kvoObject.name = @"Tome";
            
        }
        if (indexPath.row == 1) {
            self.kvoObject.phone = @"8888";
        }
        if (indexPath.row == 2) {
            self.kvoObject.title = @"cat";
        }
        if (indexPath.row == 3) {
            NSMutableArray *role = [self.kvoObject mutableArrayValueForKey:@"role"];
            [role addObjectsFromArray:@[@"cc",@"dd",@"ee"]];
            [role removeObjectAtIndex:0];
        }
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            [self.kvoObject setValue:@"Jerry" forKey:NSStringFromSelector(@selector(name))];
            [self.kvoObject setValue:@"66666" forKey:NSStringFromSelector(@selector(phone))];
            
            [self.kvoObject setValue:@"cat" forKeyPath:@"store.what"];
            [self.kvoObject setValue:@"deep" forKey:@"undefinedKey"];
            /*
             成员变量也可以用kvc 和kvo。
             通过kvc设置成员变量的值时可以触发kvo，直接修改时则需要调用willChangeValueForKey
             和didChangeValueForKey两个方法。
             */
            [self.kvoObject setValue:@"set inner by kvc" forKey:@"_innerValue"];
            
            [self.kvoObject updateInnerValue:@"set inner by message"];
        }
        else if (indexPath.row == 1)
        {
            NSLog(@"value for name :%@",[self.kvoObject valueForKey:@"name"]);
            NSLog(@"value for phone :%@",[self.kvoObject valueForKey:@"phone"]);
            NSLog(@"value for cv :%@",[self.kvoObject valueForKey:@"cv"]);
            NSLog(@"value for _innerValue :%@",[self.kvoObject valueForKey:@"_innerValue"]);
            
            NSLog(@"value for undefinedKey :%@",[self.kvoObject valueForKey:@"undefinedKey"]);
            
            
            NSLog(@"value for store.what :%@",[self.kvoObject valueForKeyPath:@"store.what"]);
        }
        
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            NSLog(@"sum for access :%@",[self.kvoObject valueForKeyPath:@"access.@sum.self"]);
        }
        
        if (indexPath.row == 1) {
            NSLog(@"max for access :%@",[self.kvoObject valueForKeyPath:@"access.@max.self"]);
        }
        if (indexPath.row == 2) {
            NSLog(@"min for access :%@",[self.kvoObject valueForKeyPath:@"access.@min.self"]);
        }
        if (indexPath.row == 3) {
            NSLog(@"avg for access :%@",[self.kvoObject valueForKeyPath:@"access.@avg.self"]);
        }
        if (indexPath.row == 4) {
            NSLog(@"distinctUnionOfObjects for access :%@",[self.kvoObject valueForKeyPath:@"access.@distinctUnionOfObjects.self"]);
        }
        if (indexPath.row == 5) {
            NSLog(@"unionOfObjects for access :%@",[self.kvoObject valueForKeyPath:@"access.@unionOfObjects.self"]);
        }
    }
}
@end
