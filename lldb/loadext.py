#!/usr/bin/env python3

import lldb
import os

def load(debugger, command, result, dict):
    FILE_PATH = os.path.join(os.path.dirname(__file__), 'swift/DebugExtensions.swift')
    with open(FILE_PATH, 'r') as f:
        lldb.debugger.HandleCommand('e -l swift -- ' + f.read())

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f loadext.load loadext')
