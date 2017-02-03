# Unit test for Task::TalkNPC
package TaskTalkNPCTest;

use strict;
use Test::More;

use Task::TalkNPC;

our @taskHooks = qw(
	npc_talk
	packet/npc_talk_continue
	npc_talk_done
	npc_talk_responses
	packet/npc_talk_number
	packet/npc_talk_text
	packet/npc_store_begin
	packet/npc_store_info
	packet/npc_sell_list
);

sub start {
	note "### Starting " . __PACKAGE__;
	testBasicUsage();
}

sub testBasicUsage {
	note "Testing basic usage...";
	my $task = Task::TalkNPC->new;
	for (@taskHooks) {
		ok(!Plugins::hasHook($_), "There should be no hooks before task activation");
	}
	$task->activate;
	for (@taskHooks) {
		ok(Plugins::hasHook($_), "There should be hooks after task activation");
	}
	$task->stop;
	for (@taskHooks) {
		ok(!Plugins::hasHook($_), "There should be no hooks after the task was stopped");
	}
}

1;