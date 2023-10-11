# base64.nvim

Provides a few handy bracket mappings for Base64 encoding and decoding.

## Installation

Install using your favourite plugin manager; for instance if you are using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "jasonwoodland/base64.nvim" }
```

## Usage

Easily encode or decode text in Base64 with the following key mappings:

### Normal Mode
- `[4{motion}`: Encode text specified by a Vim motion
- `]4{motion}`: Decode text specified by a Vim motion

### Visual Mode
- `{Visual}[4`: Encode visually selected text
- `{Visual}]4`: Decode visually selected text

### Whole Line
- `[44`: Encode the entire line
- `]44`: Decode the entire line

## License

See [LICENSE](LICENSE).
