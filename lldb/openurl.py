#!/usr/bin/env python3

import lldb
import lldbcommon as common
import os

from urllib.parse import urlparse


def open(debugger, exp, result, dict):
    value = common.evaluate(exp)
    typename = value.GetTypeName()
    if typename not in ['Swift.String', 'Foundation.NSMutableString']:
        print('Incompatible type: ' + typename)
        return

    url = value.GetObjectDescription().replace('"', '')
    u = urlparse(url)
    if u.scheme in ['http', 'https']:
        os.system('open ' + url)
    else:
        print('Failed to open: ' + url)


def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f openurl.open openurl')
