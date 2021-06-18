#!/usr/bin/env python3

import lldb


def debugo(debugger, name, result, dict):
    lldb.debugger.HandleCommand('e %s.debug("::%s").subscribe()' % (name, name))


def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f debugo.debugo deo')
