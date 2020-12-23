//
//  ViewController.m
//  ASTestFramework
//
//  Created by Mac on 2020/12/19.
//

#import "ViewController.h"
#import <ADSafeObjectFramework/ADSafeObjectFramework.h>

@interface Person : NSObject
@property (nonatomic , copy) NSString *name;
@end

@implementation Person
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testSafeObjectCrash];
    [self testArray];
//    [self preventDictionaryPassNilCrashProblem];
}

#pragma mark- 数组、字典、字符串下标越界
- (void)testSafeObjectCrash {
    
    // 测试数组
    NSArray *arr = @[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2"];
    NSMutableArray *tableArray = [[NSMutableArray alloc] initWithArray:arr];
    NSLog(@"arr====%@   tableArray====%@",arr[100],tableArray[100]);
    NSLog(@"arr====%@   tableArray====%@",[arr objectAtIndex:100],tableArray[100]);

    // 测试字典
    NSString *address = nil;
    NSDictionary *dict = @{@"name":@"", @"age":@"20", @"address":address};
    NSMutableDictionary *tableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    NSLog(@"dict---name====%@   tableDict---age====%@",[dict objectForKey:@"name"],[tableDict objectForKey:@"age"]);
    NSLog(@"dict---name====%@   tableDict---age====%@",[dict objectForKey:@"name"],[tableDict objectForKey:@"age"]);
    NSLog(@"dict---address====%@   tableDict---address====%@",[dict objectForKey:@"address"],[tableDict objectForKey:@"address"]);
    
    // 测试字符串
    NSMutableString *tableString = [[NSMutableString alloc] initWithFormat:@"防止项目数组字典越界崩溃"];
    NSLog(@"%@",[tableString substringFromIndex:100]);
}

#pragma mark- 数组创建和下标越界 - 通过nil元素创建数组奔溃处理
- (void)testArray {
    /** 不可变数组 */
    //角标越界
    //数组 = nil
    NSArray *array = nil;
    NSLog(@"array[1] = %@",array[2]);
    
    //count = 0
    NSArray *array1 = @[];
    NSLog(@"array1[1] = %@",array1[2]);
    
    //只有一个元素
    NSArray *array2 = @[@"123"];
    NSLog(@"array2[2] = %@",array2[2]);
    
    //多个元素
    NSArray *array3 = @[@"123",@"321",@"456"];
    NSLog(@"array3[8] = %@",array3[8]);
    
    //创建数组传入nil
    NSArray *array4 = [NSArray arrayWithContentsOfURL:nil];
    NSArray *array5 = [NSArray arrayWithObjects:nil, nil];
    NSArray *array6 = [NSArray arrayWithArray:nil];
    NSArray *array7 = [NSArray arrayWithObject:nil];
    NSArray *array8 = [NSArray arrayWithObjects:nil count:1];
    
    
    /**
     * 可变指针 指向 不可变数组
     * 此种指向需要注意,如果用不可变数组对象,访问了可变数组的方法会造成崩溃
     * 下面的数组其真实类型是不可变数组
     */
    NSMutableArray *arrayI = nil;
    NSLog(@"arrayI[1] = %@",arrayI[2]);
    [arrayI addObject:nil];
    [arrayI insertObject:nil atIndex:0];
    
    
    //count = 0
    NSMutableArray *array1I = @[];
    NSLog(@"array1I[1] = %@",array1I[2]);
    //[array1I addObject:nil];//语法错误,不可变访问可变方法,崩溃
    //[array1I insertObject:nil atIndex:0];//语法错误,不可变访问可变方法,崩溃
    
    //只有一个元素
    NSMutableArray *array2I = @[@"123"];
    NSLog(@"array2I[2] = %@",array2I[2]);
    
    //多个元素
    NSMutableArray *array3I = @[@"123",@"321",@"456"];
    NSLog(@"array3I[8] = %@",array3I[8]);
    
    //创建数组传入nil
    NSMutableArray *array4I = [NSArray arrayWithContentsOfURL:nil];
    NSMutableArray *array5I = [NSArray arrayWithObjects:nil, nil];
    NSMutableArray *array6I = [NSArray arrayWithArray:nil];
    NSMutableArray *array7I = [NSArray arrayWithObject:nil];
    NSMutableArray *array8I = [NSArray arrayWithObjects:nil count:1];
    
    
    /**
     * 可变指针 指向 可变数组
     */
    NSMutableArray *arrayM = nil;
    [arrayM addObject:nil];
    [arrayM insertObject:nil atIndex:3];
    
    NSMutableArray *array1M = [NSMutableArray array];
    [array1M addObject:nil];
    [array1M insertObject:nil atIndex:0];
    
    
    NSMutableArray *array2M = [[NSMutableArray alloc] init];
    [array2M addObject:nil];
    [array2M insertObject:nil atIndex:1];
    
    NSMutableArray *array3M = [NSMutableArray arrayWithObject:@"123"];
    [array3M addObject:nil];
    [array3M insertObject:nil atIndex:1];
    
    NSMutableArray *array16M = [NSMutableArray arrayWithContentsOfURL:nil];
    NSMutableArray *array18M = [NSMutableArray arrayWithObjects:nil, nil];
    NSMutableArray *array19M = [NSMutableArray arrayWithArray:nil];
    NSMutableArray *array14M = [NSMutableArray arrayWithObject:nil];
    NSMutableArray *array15M = [NSMutableArray arrayWithObjects:nil count:1];
    
    //测试插入对象为空
    NSMutableArray *array20M = [NSMutableArray array];
    [array20M addObject:nil];
    [array20M addObject:[[Person alloc]init]];
    [array20M addObject:[[Person alloc]init]];
    NSLog(@"array16M = %@",array20M);
    id obj = array20M[0];
    if ([obj isKindOfClass:[NSNull class]]) {
        NSLog(@"我是个null");
    }
    
    Person *p1 = array20M[1];
    NSLog(@"p1.name = %@", p1.name);
}


#pragma mark- 防止字典传nil奔溃问题
- (void)preventDictionaryPassNilCrashProblem {
    
    [self loadData];
    [self testLiteral];
    [self testKeyedSubscript];
    [self testSetObject];
    [self testArchive];
    [self testJSON];
}

- (void)loadData {
    
    NSString *ww = nil;
    NSDictionary *dict = @{@"zhangsan":@"22", @"lisi":@"24", @"wangwu":ww};
    NSLog(@"dict = %@", dict);
}

- (void)testLiteral {
    
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    NSDictionary *dict = @{
        nonNilKey: nilVal,
        nilKey: nonNilVal,
    };
    NSLog(@"dict = %@", dict);
    
    id val = dict[nonNilKey];
    NSLog(@"val = %@", val);
}

- (void)testKeyedSubscript {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    dict[nonNilKey] = nilVal;
    dict[nilKey] = nonNilVal;
    NSLog(@"%@", [dict objectForKey:nonNilKey]);
}

- (void)testSetObject {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    [dict setObject:nilVal forKey:nonNilKey];
    [dict setObject:nonNilVal forKey:nilKey];
    NSLog(@"%@", [dict objectForKey:nonNilKey]);
}

- (void)testArchive {
    
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    NSDictionary *dict = @{
        nonNilKey: nilVal,
        nilKey: nonNilVal,
    };
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    NSDictionary *dict2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@", [dict2 objectForKey:nonNilKey]);
}

- (void)testJSON {
    
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    NSDictionary *dict = @{
        nonNilKey: nilVal,
        nilKey: nonNilVal,
    };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *expectedString = @"{}";
    NSLog(@"jsonString = %@, expectedString = %@", jsonString, expectedString);
}


@end
