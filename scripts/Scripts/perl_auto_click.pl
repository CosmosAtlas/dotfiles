#!/usr/bin/perl
# clicker.pl - click the living hell out of whatever's under the mouse cursor
# rely on _xdotool_ to perform the clicks

use strict;
use Time::HiRes qw (usleep nanosleep);
use warnings;

$SIG{TERM} = \&exit_handler;

# endless loop - press and hold the mouse button to stop registering click events,
# then mouse back over to the terminal and Ctrl-C to stop
while (1) {
    # 10,000 microseconds == 10 milliseconds == 1/100 of a second.
    # 2 of these per loop means ~~ 50 clicks per second.

    print `/usr/bin/xdotool mousedown 1`;
    usleep(10000);
    print `/usr/bin/xdotool mouseup 1`;
    usleep(10000);
}

# when halted, make sure to reset mouse state to mouse up to avoid unwanted
# behaviour after the script is killed
sub exit_handler {
    print `/usr/bin/xdotool mouseup 1`;
    exit 0;
}
