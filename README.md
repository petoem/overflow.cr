# overflow.cr

[![Build Status](https://travis-ci.org/petoem/overflow.cr.svg?branch=master)](https://travis-ci.org/petoem/overflow.cr)

**[Experiment]** Wrap integer into `SafeBox(T)` to prevent/raise on overflow. Inspired by this [gist](https://gist.github.com/endSly/3226a22f91689e7eae338fd647d6c785).

> *Note: Do not use in production! You have been warned.*

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  overflow:
    github: petoem/overflow.cr
```

This shard links against `libclang_rt.builtins-*.a` which is part of [`compiler-rt`](https://compiler-rt.llvm.org/). It is needed to fix this [error](https://travis-ci.org/petoem/overflow/builds/382581073#L553) related to `Int128` multiplication.

You will have to install `clang` because it is used to discover the location of the compiler runtime library. Above file is provided by package [compiler-rt](https://www.archlinux.org/packages/extra/x86_64/compiler-rt/) on ArchLinux and [libclang-common](https://packages.debian.org/stretch/libclang-common-3.9-dev) on Debian (both dependencies of `clang` package). Hence, installing `clang` should be enough.

## Usage

`overflow.cr` shard provides `SafeBox(T)`, which helps you prevent integer overflow.  
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

## Known Issues

- In a computation e.g. `a + b`, the right operand type is always extended or trimmed to the left operand type.

## Contributing

1. [Fork it](https://github.com/petoem/overflow.cr/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [petoem](https://github.com/petoem) Michael Petö - creator, maintainer
