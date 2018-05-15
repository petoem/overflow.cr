require "./overflow/version"
require "./overflow/intrinsics"
require "./overflow/exception"
require "./overflow/safebox"
require "./overflow/int"
require "./overflow/operator"
require "./overflow/conversion"

s = SafeBox.new 5_i8
pp s

b = SafeBox.new 100_i8
pp b

pp (s + b)

c = SafeBox.new Int8::MAX
pp c

# pp (s + c)

f = SafeBox.new 300_u32
pp f
# pp f.to_i8

pp (1_u64 + s)

pp (2.5 * f)
