#!/usr/bin/env python3

import lldb


def evaluate(exp):
    options = lldb.SBExpressionOptions()
    options.SetLanguage(lldb.eLanguageTypeSwift)
    options.SetTimeoutInMicroSeconds(3 * 1000 * 1000)
    options.SetTrapExceptions(False)

    value = (
        lldb.debugger.GetSelectedTarget()
        .GetProcess()
        .GetSelectedThread()
        .GetSelectedFrame()
        .EvaluateExpression(exp, options)
    )

    return value
