struct Int
  {% for operator in ["+", "-", "*"] %}
    def {{operator.id}}(other : SafeBox(T)) : SafeBox(self) forall T
      SafeBox.new(self) {{operator.id}} other
    end
  {% end %}
end
