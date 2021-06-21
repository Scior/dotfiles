#!/usr/bin/env python3

import lldb
import uuid


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


def evaluateObjC(exp):
    options = lldb.SBExpressionOptions()
    options.SetLanguage(lldb.eLanguageTypeObjC_plus_plus)
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


def generateVarName():
    return str(uuid.uuid4()).replace('-', '')
