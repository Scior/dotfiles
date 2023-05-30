#!/usr/bin/env python3

import json
import lldb
import lldbcommon as common


@lldb.command("pjson")
def print_json(debugger, exp, result, dict):
    value = common.evaluate(exp)
    typename = value.GetTypeName()
    if typename not in ['Swift.String', 'Foundation.NSMutableString']:
        print('Incompatible type: ' + typename)
        return

    json_str = value.GetObjectDescription().encode().decode("unicode-escape")[1:-2]
    json_dict = json.loads(json_str)
    print(json.dumps(json_dict, indent=2, separators=(',', ': ')))
