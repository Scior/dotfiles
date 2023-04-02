#!/usr/bin/env python3

import lldb
import lldbcommon as common
import os

from urllib.parse import urlparse


@lldb.command("openurl")
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
