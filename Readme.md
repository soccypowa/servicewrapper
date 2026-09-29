# Simple service wrapper to run an executable as a windows service

## Background

I needed a simple tool that could run an executable, from the beginning InfluxDB2, as a Windows service. At the moment it seemed like the only way of doing this was to use the **Non-Sucking Service Manager**, which already seemed depricated. From all I saw the main problem was to re-route the output that came from the executable at hand to somewhere else.

So that is what this do. It started out as just taking an executable, wrapping it, running it as a service. A little later the need arose to be able to send some flags into that executable, so I updated it to be able to handle that too.

## Example creating a service using sc.exe

```sh
# Remember there is an alias i pwsh for sc
sc.exe create <service_name> binPath= "<path_to_wrapper_exe> <path_to_wrapped_exe> <flags_if_any_for_wrapped_exe>"

sc.exe delete <service_name>
```

## Info

* stdout and stderr will be written to a file under c:\logs the filename will contain the wrapped executable's name.

* file size is limited to 50MB and 10 files are kept on disk.

* This should be developed and built on Windows

## Note

Uses: Lumberjack, windows/svc
