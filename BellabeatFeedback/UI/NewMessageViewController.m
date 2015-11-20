//
//  NewMessageViewController.m
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 20/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import "NewMessageViewController.h"

@interface NewMessageViewController ()

@property (nonatomic, strong) MessageDataStore *dataStore;
@property (nonatomic, strong) MessageModel *message;

@end

@implementation NewMessageViewController

#pragma mark - Init

- (instancetype)initWithDataStore:(MessageDataStore *)dataStore {
    NSParameterAssert(dataStore);
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        self.dataStore = dataStore;
        self.message = [[MessageModel alloc] initWithDataStore:self.dataStore];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"NewMessageViewController dealloc");
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"New message";
    
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveTapped:)];
    self.navigationItem.rightBarButtonItem = saveBarButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.inputTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveTapped:(id)sender {
    self.message.message = self.inputTextView.text;
    self.message.timestamp = [NSDate date];
    [self.dataStore saveMessage:self.message];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
