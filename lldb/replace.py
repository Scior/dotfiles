#!/usr/bin/env python3

import lldb


def replace(debugger, command, result, dict):
    lldb.debugger.HandleCommand('e -l swift -- ' + command)
    lldb.debugger.HandleCommand('th j -b 1')


def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f replace.replace replace')
