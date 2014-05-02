//
//  TaskViewController.m
//  ToDo
//
//  Created by Zi on 2/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "TaskViewController.h"
#import "Task.h"

@interface TaskViewController ()

@property (strong) UITableView *tableView;
@property (copy) NSArray *array;
@property (strong) UIButton *addButton;

@end

@implementation TaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadFromDisk];
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"UITableViewCell"];
    self.title = @"Task";
    
    [self.view addSubview: self.tableView];
    
    //    Task *task1 = [[Task alloc] init];
    //    task1.name = @"clean";
    //    Task *task2 = [[Task alloc] init];
    //    task2.name = @"eateateateateateateateateateateateateat";
    //
    //    self.array = [NSArray arrayWithObjects: task1, task2, nil];
	// Do any additional setup after loading the view, typically from a nib.
    self.addButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 20, 20)];
    self.addButton.backgroundColor = [UIColor blackColor];
    [self.addButton setTitle: @"Add" forState: UIControlStateNormal];
    [self.addButton sizeToFit];
    [self.addButton addTarget: self action: @selector(addButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(addNotification:) name: @"addNewTask" object: nil];
}

- (void) addNotification: (NSNotification *) notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *name = userInfo[@"name"];
    [self addTaskWithName: name];
}

- (void) viewWillAppear:(BOOL)animated {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView: self.addButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void) addButtonTapped: (UIButton *) button {
    AddViewController *addViewController = [[AddViewController alloc] init];
//    addViewController.delegate = self;
    [self.navigationController pushViewController: addViewController animated: YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"UITableViewCell"];
    Task *task = [self.array objectAtIndex: indexPath.row];
    cell.textLabel.text = task.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray: self.array];
        [mutableArray removeObjectAtIndex: indexPath.row];
        self.array = mutableArray;
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];
        [self saveToDisk];
    }
}

- (void) saveToDisk {
    NSMutableArray *toSaved = [NSMutableArray array];
    [self.array enumerateObjectsUsingBlock:^(Task *task, NSUInteger idx, BOOL *stop) {
        [toSaved addObject: task.name];
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject: toSaved forKey: @"tasks"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) loadFromDisk {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey: @"tasks"];
    NSMutableArray *tasks = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL *stop) {
        Task *task = [Task new];
        task.name = string;
        [tasks addObject: task];
    }];
    
    self.array = tasks;
}

- (void) addViewController:(AddViewController *)viewController addedTaskWithName:(NSString *)name {
    [self addTaskWithName: name];
}

- (void) addTaskWithName: (NSString *) name {
    if (![name isEqualToString: @""]) {
        Task *task = [Task new];
        task.name = name;
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray: self.array];
        [mutableArray addObject: task];
        self.array = mutableArray;
        [self.tableView beginUpdates];
        
        [self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject: [NSIndexPath indexPathForRow: self.array.count - 1 inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];
        [self saveToDisk];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
