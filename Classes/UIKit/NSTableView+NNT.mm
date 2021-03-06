
# import "Core.h"
# import "NSTableView+NNT.h"

signal_t kSignalSelectChanged = @"::nnt::ui::select::changed";

NNT_BEGIN_OBJC

@implementation NNTNSTableView

- (void)deselectSelection {
    [self deselectColumn:self.selectedColumn];
    [self deselectRow:self.selectedRow];
}

@end

@implementation _cxx_nstableview

@end

/*
@implementation nstable_datasource

@synthesize data, ctlr_data;

- (id)init {
    self = [super init];
    ctlr_data = [[NSArrayController alloc] init];
    return self;
}

- (void)dealloc {
    zero_release(data);
    zero_release(ctlr_data);
    [super dealloc];
}

- (id)tableView:(NSTableView *) aTableView objectValueForTableColumn:(NSTableColumn*)aTableColumn row:(NSInteger)rowIndex {  
    return [self.data objectAtIndex:rowIndex];  
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [self.data count];  
}

@end

@implementation nstable_delegate

@synthesize table;
@synthesize editable;

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    //int row = [table selectedRow];
    //if (row != -1)
    //    target->emit(kSignalSelectChanged, &row);
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return editable;
}

@end
 */

NNT_END_OBJC