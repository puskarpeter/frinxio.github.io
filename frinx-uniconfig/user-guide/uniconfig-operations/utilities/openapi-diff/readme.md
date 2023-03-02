# Difference between OpenAPI specifications

## Introduction

The Uniconfig distribution includes a program for checking the difference between OpenAPI specifications. 
After building and unpacking the distribution, you can find the program in the 'utils' directory as a shell
script called called 'show_swagger_diff.sh'.

The program uses [OpenAPI-diff](https://github.com/OpenAPITools/openapi-diff) to generate OpenAPI differences.

## Usage

The ```./show_swagger_diff.sh``` script contains four arguments. Each one has its own identifier, so you can give arguments
in any order. All arguments are optional as default values are included for each argument.

* ```--former, -f /path/to/former/yaml/files``` - optional argument. Path to previous OpenAPI specifications (.yaml files). The default path is 'openapi_diff/old'.
* ```--new, -n /path/to/new/yaml/files``` - optional argument. Path to new OpenAPI specifications (.yaml files). The default path is 'openapi_diff/new'.
* ```--output, -o /path/to/output``` - optional argument. Path for the html output file with differences. The default path is 'openapi_diff'.
* ```-s``` - optional argument. Silent printing, includes less information.

!!!
Bash script ```./show_swagger_diff.sh``` also includes a simple help facility. There are two options for showing the help text:
1. ```./show_swagger_diff.sh -h```
2. ```./show_swagger_diff.sh --help```
!!!

!!!
The script only accepts YAML files.
!!!

## Example use case

### Default usage

This example shows basic usage of the script with and without optional arguments. Open a terminal
and the  '../utils' directory, and run the following command:

```console
./show_swagger_diff.sh
```

OR

```console
./show_swagger_diff.sh -f openapi_diff/old -n openapi_diff/new -o openapi_diff
```

```console Output:
Directory openapi_diff/old and openapi_diff/new exist.
Starting openapi-diff for 'OpenAPI_specification_1'...
'OpenAPI_specification_1' was deleted in the new version.

Starting openapi-diff for 'OpenAPI_specification_2'...
Diff for 'OpenAPI_specification_2' successful

Starting openapi-diff for 'OpenAPI_specification_3'...
No differences. Specifications are equivalents. Skipping 'OpenAPI_specification_3'...

Open openapi_diff/openapi_diff.html in web browser to view all the differences between old and new modules.
```

### Usage with non-existent input path

This example shows basic usage of the script where some specified input directories do not exist. Open a terminal
and the '../utils' directory, and run the following command:

```console
./show_swagger_diff.sh -n non/existent/path
```

```console Output:
Error: Directory openapi_diff/old or non/existent/path does not exist.
```
