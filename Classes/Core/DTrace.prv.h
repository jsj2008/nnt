
# ifndef __NNT_DTRACE_13D9ACE294784D59948FF74DD87E8396_H_INCLUDED
# define __NNT_DTRACE_13D9ACE294784D59948FF74DD87E8396_H_INCLUDED

# ifdef NNT_DEBUG
#   define DTRACE_VIEWCONTROLLER_COUNTER
# endif

# ifdef DTRACE_VIEWCONTROLLER_COUNTER
extern long dtrace_viewcontroller_counter;
#   define DTRACE_VIEWCOUNTROLLER_COUNTER_INC ++dtrace_viewcontroller_counter;
#   define DTRACE_VIEWCOUNTROLLER_COUNTER_DESC --dtrace_viewcontroller_counter;
# else
#   define DTRACE_VIEWCOUNTROLLER_COUNTER_INC
#   define DTRACE_VIEWCOUNTROLLER_COUNTER_DESC
# endif

# endif