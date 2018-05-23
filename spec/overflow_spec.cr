require "./spec_helper"

describe SafeBox do
  {% for type_left in Int::Primitive.union_types %}
    describe "SafeBox({{type_left}})#+" do
     {% for type_right in Int::Primitive.union_types %}
      it "returns expected result for SafeBox({{type_right}})" do
        result = SafeBox.new({{type_left}}.new(5)) + SafeBox.new({{type_right}}.new(5))
        result.should eq SafeBox.new {{type_left}}.new(10)
      end

      it "returns expected result for {{type_right}}" do
        result = SafeBox.new({{type_left}}.new(5)) + {{type_right}}.new(5)
        result.should eq SafeBox.new {{type_left}}.new(10)
      end

      it "raises IntegerOverflow exception on upper bound" do
        expect_raises(IntegerOverflow, "SafeBox({{type_left}}) {{Int::Unsigned.union_types.includes?(type_left) ? :u.id : :s.id}}add {{type_right}}") do
          SafeBox.new({{type_left}}::MAX) + {{type_right}}.new(1)
        end
      end
      {% end %}
    end

    describe "SafeBox({{type_left}})#-" do
      {% for type_right in Int::Primitive.union_types %}
        it "returns expected result for SafeBox({{type_right}})" do
          result = SafeBox.new({{type_left}}.new(10)) - SafeBox.new({{type_right}}.new(5))
          result.should eq SafeBox.new {{type_left}}.new(5)
        end

        it "returns expected result for {{type_right}}" do
          result = SafeBox.new({{type_left}}.new(10)) - {{type_right}}.new(5)
          result.should eq SafeBox.new {{type_left}}.new(5)
        end

        it "raises IntegerOverflow exception on lower bound" do
          expect_raises(IntegerOverflow, "SafeBox({{type_left}}) {{Int::Unsigned.union_types.includes?(type_left) ? :u.id : :s.id}}sub {{type_right}}") do
            SafeBox.new({{type_left}}::MIN) - {{type_right}}.new(1)
          end
        end
      {% end %}
    end

    # FIXME: undefined reference to `__muloti4'
    # Needed for Int128 multiplication
    # fix maybe with compiler-rt ?
    describe "SafeBox({{type_left}})#*" do
      {% for type_right in Int::Primitive.union_types %}
        it "returns expected result for SafeBox({{type_right}})" do
          result = SafeBox.new({{type_left}}.new(10)) * SafeBox.new({{type_right}}.new(2))
          result.should eq SafeBox.new {{type_left}}.new(20)
        end

        it "returns expected result for {{type_right}}" do
          result = SafeBox.new({{type_left}}.new(10)) * {{type_right}}.new(2)
          result.should eq SafeBox.new {{type_left}}.new(20)
        end
      {% end %}
    end
  {% end %}
end
