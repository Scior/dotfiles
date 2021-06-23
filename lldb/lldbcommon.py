#!/usr/bin/env python3

import lldb
import uuid


def evaluate(exp):
    options = lldb.SBExpressionOptions()
    options.SetLanguage(lldb.eLanguageTypeSwift)
    options.SetTimeoutInMicroSeconds(3 * 1000 * 1000)
    options.SetTrapExceptions(False)

    frame = (
        lldb.debugger.GetSelectedTarget()
        .GetProcess()
        .GetSelectedThread()
        .GetSelectedFrame()
    )

    value = frame.EvaluateExpression(exp, options)
    error = value.GetError()
    if not error.Success() and error.value != 0x1001:
        print(error)
        
    return value


def evaluateObjC(exp):
    options = lldb.SBExpressionOptions()
    options.SetLanguage(lldb.eLanguageTypeObjC_plus_plus)
    options.SetTimeoutInMicroSeconds(3 * 1000 * 1000)
    options.SetTrapExceptions(False)

    frame = (
        lldb.debugger.GetSelectedTarget()
        .GetProcess()
        .GetSelectedThread()
        .GetSelectedFrame()
    )

    return frame.EvaluateExpression(exp, options)


def generateVarName():
    return str(uuid.uuid4()).replace('-', '')
