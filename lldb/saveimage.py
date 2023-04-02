#!/usr/bin/env python3

import lldb
import lldbcommon as common
import os
import uuid


@lldb.command("saveimage")
def save_image(debugger, arguments, result, dict):
    view, path = arguments.split()

    # 引数がUIViewかチェック
    is_ui_view = common.evaluate('%s is UIView' % view).GetObjectDescription().rstrip()
    if is_ui_view != 'true':
        print('UIView must be passed to the first argument')
        return

    var_name = str(uuid.uuid4()).replace('-', '')
    common.evaluate('let $%s = %s.convertToPNGData()' % (var_name, view))
    # アドレス周りはObjCの方がきれいに書ける
    address_str = common.evaluate('($%s as NSData).bytes' % var_name).GetObjectDescription().split()[1]
    address = int(address_str, 16)
    size = int(common.evaluate('$%s.count' % var_name).GetValue())

    # メモリから画像をPython側にロードしてファイルに書き込み
    process = lldb.debugger.GetSelectedTarget().GetProcess()
    error = lldb.SBError()
    data = process.ReadMemory(address, size, error)
    if not error.Success():
        print(error)
    elif size != len(data):
        print('data is corrupted')
    else:
        with open(path, "wb") as f:
            f.write(data)
        print("The image has been written to: %s" % path)
