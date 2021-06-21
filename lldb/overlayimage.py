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
    common.evaluate('let $buf = ImageBuffer(size: %s)' % len(data))
    address_str = common.evaluate('$buf.pointer').GetObjectDescription().split()[1]
    address = int(address_str, 16)

    process = lldb.debugger.GetSelectedTarget().GetProcess()
    error = lldb.SBError()
    result = process.WriteMemory(address, data, error)
    print(result)
    if not error.Success() or result != len(data):
        print(error)

    common.evaluate('let $ov = DebugOverlayView(frame: %s.frame)' % view)
    common.evaluate('$ov.set(data: $buf.getData()))')
    common.evaluate('view.addSubview($ov)')
