# Provides mappings from symbols to standard OpenGL constants.
#
# :line_strip # => GL_LINE_STRIP
# :points     # => GL_POINTS
#
# TODO: For now, the mapping is global, needs to be scoped by usage.
module Constants
  def gl_constant(type)
    case type
    when :line_strip then GL_LINE_STRIP
    when :points     then GL_POINTS
    else
      raise "Unknown constant lookup"
    end
  end
end
