#!/usr/bin/env python3

import lldb
import lldbcommon as common
import os


@lldb.command("overlayimage")
def overlay_image(debugger, arguments, result, dict):
    view, path = arguments.split()
    with open(path, 'rb') as f:
        data = f.read()
    # unsafeBitCast
    print(len(data))
    address = common.evaluate('let $buf = ImageBuffer(size: %s)' % len(data))
    address = int(common.evaluate('$buf').GetValue(), 16)
    print(address)
    process = lldb.debugger.GetSelectedTarget().GetProcess()
    error = lldb.SBError()
    data = data[0:10000]
    result = process.WriteMemory(address, data, error)
    print(result)
    if not error.Success() or result != len(data):
        print(error)

    common.evaluate('let $ov = DebugOverlayView(frame: %s.frame)' % view)
    common.evaluate('$ov.setImage(data: $buf.getData()))')
    print('c')
    common.evaluate('$s.superview.addSubview($ov)')
    print('d')
