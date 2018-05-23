@[Link(ldflags: "`clang -rtlib=compiler-rt -print-libgcc-file-name`")]
lib Intrinsics
  {% for oper in %i(sadd ssub smul) %}
    {% for name, type in {i8: Int8, i16: Int16, i32: Int32, i64: Int64, i128: Int128} %}
      fun {{oper.id}}_{{name}}_with_overflow = "llvm.{{oper.id}}.with.overflow.{{name}}"(a : {{type}}, b : {{type}}) : { {{type}}, Bool }
    {% end %}
  {% end %}
  {% for oper in %i(uadd usub umul) %}
    {% for name, type in {i8: UInt8, i16: UInt16, i32: UInt32, i64: UInt64, i128: UInt128} %}
      fun {{oper.id}}_{{name}}_with_overflow = "llvm.{{oper.id}}.with.overflow.{{name}}"(a : {{type}}, b : {{type}}) : { {{type}}, Bool }
    {% end %}
  {% end %}
end
