#!/usr/bin/python3

# This add header to Hearts and Minds mission (HaM)
from pathlib import Path
import re

def btc_fnc_generate_header(file_name, folder_name, parameters_array):
    function_name = "btc_%s_fnc_%s" % (folder_name, file_name)
    parameters_string = ''
    for param in parameters_array:
        parameters_string = parameters_string + ('''    %s - [%s]\n''' % (param[0], param[1]))

    header_for_HaM = '''
/* ----------------------------------------------------------------------------
Function: %s

Description:
    Fill me when you edit me !

Parameters:
%s
Returns:

Examples:
    (begin example)
        _result = [] call %s;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

''' % (function_name, parameters_string, function_name)
    return header_for_HaM

def btc_fnc_write_header(header, path, text_in_file):
    text_in_file_with_header = path.write_text(header + text_in_file)
    return text_in_file_with_header

def btc_fnc_get_file_folder_name(path):
    file_name = (path.name)[:-4:]
    folders_name = path.parts
    folder_name = folders_name[-2]
    return file_name, folder_name

def btc_fnc_get_param(text):
    re2='((?:[a-z][a-z0-9_]*))'

    rg = re.compile(re2,re.IGNORECASE|re.DOTALL)
    m = rg.search(text)
    if m:
        string1=m.group(1)
        return '_' + string1
    return ""

def btc_fnc_get_params(text):
    re2='("_.*?")|'
    re3='(\\["_.*?")'

    pattern = re.compile(re2+re3,re.IGNORECASE|re.DOTALL)
    parameters_array = []
    typeOf_param = btc_fnc_get_typeOf_param(text)
    for index, param in enumerate(re.findall(pattern, text)):
        first, second = param
        _typeOf_index = ''
        if first != '':
            parameters_array.append([btc_fnc_get_param(first), _typeOf_index])
        if second != '':
            if index < len(typeOf_param):
                _typeOf_index = typeOf_param[index]
                if ' [objNull]]' in _typeOf_index:
                    _typeOf_index = 'Object'
                elif ' [grpNull]]' in _typeOf_index:
                    _typeOf_index = 'Group'
                elif ' [0]]' in _typeOf_index:
                    _typeOf_index = 'Number'
                elif ' [[]]]' in _typeOf_index:
                    _typeOf_index = 'Array'
                elif ' [{}]]' in _typeOf_index:
                    _typeOf_index = 'Code'
                elif ' [true]]' in _typeOf_index:
                    _typeOf_index = 'Boolean'
                elif ' [false]]' in _typeOf_index:
                    _typeOf_index = 'Boolean'
                elif ' [east]]' in _typeOf_index:
                    _typeOf_index = 'Side'
                elif ' [west]]' in _typeOf_index:
                    _typeOf_index = 'Side'
                elif ' [displayNull]]' in _typeOf_index:
                    _typeOf_index = 'Display'
                elif ' [controlNull]]' in _typeOf_index:
                    _typeOf_index = 'Control'
                elif ' [""]]' in _typeOf_index:
                    _typeOf_index = 'String'
                else:
                    _typeOf_index = ''
            parameters_array.append([btc_fnc_get_param(second), _typeOf_index])
    return parameters_array

def btc_fnc_get_typeOf_param(text):
    re2='( \\[""\\]\\])|'
    re4='( \\[objNull\\]\\])|'
    re6='( \\[grpNull\\]\\])|'
    re8='( \\[0\\]\\])|'
    re10='( \\[\\[\\]\\]\\])|'
    re12='( \\[true\\]\\])|'
    re14='( \\[false\\]\\])|'
    re16='( \\[\\{\\}\\]\\])|'
    re18='( \\[east\\]\\])|'
    re20='( \\[west\\]\\])|'
    re22='( \\[displayNull\\]\\])|'
    re24='( \\[controlNull\\]\\])'

    rg = re.compile(re2+re4+re6+re8+re10+re12+re14+re16+re18+re20+re22+re24,re.IGNORECASE|re.DOTALL)
    m = rg.findall(text)
    if m:
        return m
    return ()

def btc_fnc_detect_params(txt):
    re1='(params \\[.*?\\]\\;)'
    rg = re.compile(re1,re.IGNORECASE|re.DOTALL)
    m = rg.search(txt)
    if m:
        parameters = m.group(1)
        return parameters
    return ""

folder_of_HaM = r"..\=BTC=co@30_Hearts_and_Minds.Altis\core\fnc"
# Scan folder and subfolder for .sqf files
pathlist = Path(folder_of_HaM).glob('**/*.sqf')
for path in pathlist:
    text_in_file = path.read_text()
    file_name, folder_name = btc_fnc_get_file_folder_name(path)
    # Add header to .sqf without header
    if (file_name != "compile" and text_in_file.find("/* ----------------------------------------------------------------------------") == -1):
        parameters = btc_fnc_detect_params(text_in_file)
        parameters_array = []
        if parameters != "":
            parameters_array = btc_fnc_get_params(parameters)
        header = btc_fnc_generate_header(file_name, folder_name, parameters_array)
        btc_fnc_write_header(header, path, text_in_file)
