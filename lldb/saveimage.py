#!/usr/bin/env python3

import lldb
import lldbcommon as common
import os


@lldb.command("saveimage")
def save_image(debugger, arguments, result, dict):
    view, path = arguments.split()

    is_ui_view = common.evaluate('%s is UIView' % view).GetObjectDescription().rstrip()
    if is_ui_view != 'true':
        print('UIView must be passed to the first argument')
        return

    common.evaluate('let $data = %s.convertToPNGData()' % view)
    # アドレス周りはObjCの方がきれいに書ける
    address_str = common.evaluate('($data as NSData).bytes').GetObjectDescription().split()[1]
    address = int(address_str, 16)
    size = int(common.evaluate('$data.count').GetValue())

    process = lldb.debugger.GetSelectedTarget().GetProcess()
    error = lldb.SBError()
    data = process.ReadMemory(address, size, error)
    if not error.Success() or size != len(data):
        print(error)
    else:
        with open(path, "wb") as f:
            f.write(data)
        print("An image has been written to: %s" % path)
