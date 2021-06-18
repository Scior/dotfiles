#!/usr/bin/env python3

import lldb


def evaluate(exp):
    value = (
        lldb.debugger.GetSelectedTarget()
        .GetProcess()
        .GetSelectedThread()
        .GetSelectedFrame()
        .EvaluateExpression(exp)
    )

    return value