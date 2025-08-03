# Nvim config

nvim config based on tjdevries advent of neovim series with doomemacs keybindings + alot more

## .mvim file

This .mvim (not a typo) file is a json file ment to specify project specfic settings like if format on save should be enabled or debugger configurations.

example

```json
{
    "format_on_save": false,
    "debuggers": {
        "cs": [
            {
                "name": "Client",
                "cwd": "MyApp.Client",
                "dll": "MyApp.Client/bin/Debug/net8.0/MyApp.Client.dll"
            },
            {
                "name": "Server",
                "cwd": "MyApp.Server",
                "dll": "MyApp.Server/bin/Debug/net8.0/MyApp.Server.dll"
            }
        ]
    }
}
```
