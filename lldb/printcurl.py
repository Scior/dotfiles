#!/usr/bin/env python3

import lldb
import lldbcommon as common
import os


@lldb.command("curl")
def print_curl(debugger, exp, result, dict):
    path = os.path.join(os.path.dirname(__file__), 'swift/URLRequest+curlCommand.swift')
    with open(path, 'r') as f:
        common.evaluate(f.read())

    common.evaluate(f'print({exp}.curlCommand!)')
