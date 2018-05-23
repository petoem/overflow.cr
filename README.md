# overflow

**[WIP]** Wrap integer into `SafeBox(T)` to prevent/raise on overflow. Inspired by this [gist](https://gist.github.com/endSly/3226a22f91689e7eae338fd647d6c785).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  overflow:
    github: petoem/overflow
```

For now this shard tries link against `libclang_rt.builtins-x86_64.a` which is part of [`compiler-rt`](https://github.com/llvm-mirror/compiler-rt). It is needed to fix this [error](https://travis-ci.org/petoem/overflow/builds/382581073#L553) related to `Int128` multiplication.

You will have to install [clang](https://www.archlinux.org/packages/extra/x86_64/clang/).
The above file is provided by package [compiler-rt](https://www.archlinux.org/packages/extra/x86_64/compiler-rt/) on ArchLinux and [libclang-common](https://packages.debian.org/stretch/libclang-common-3.9-dev) on Debian.

## Usage

`overflow` shard provides `SafeBox(T)`, which helps you prevent integer overflow.  
Operations like `+, -, *` on an integer stored inside `SafeBox(T)` are done using [LLVM Intrinsics](https://llvm.org/docs/LangRef.html#arithmetic-with-overflow-intrinsics) and `SafeBox(T)#to_*` methods are checked for overflow too.  
All other method calls are forwarded to the integer `value` stored inside using `forward_missing_to` macro.
```crystal
require "overflow"

# Short example
struct Color
  getter r : SafeBox(UInt8)
  getter g : SafeBox(UInt8)
  getter b : SafeBox(UInt8)

  def initialize(@r, @g ,@b); end
end

# Create cyan color
cyan = Color.new 0_u8.to_sb, 255_u8.to_sb, 255_u8.to_sb

# Lets look what it stores ...
pp cyan # => Color(
        #     @b=SafeBox(UInt8)(@type=UInt8, @value=255_u8),
        #     @g=SafeBox(UInt8)(@type=UInt8, @value=255_u8),
        #     @r=SafeBox(UInt8)(@type=UInt8, @value=0_u8))

# and now make it a bit more blue.
blue = cyan.b + 20 # SafeBox(UInt8) uadd Int32 (IntegerOverflow)

# Oops ... to much blue.
```

That's it for now.

## Development

TODO: Write development instructions here

## Contributing

1. [Fork it](https://github.com/petoem/overflow/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [petoem](https://github.com/petoem) Michael Petö - creator, maintainer
