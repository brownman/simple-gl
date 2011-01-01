require 'glut'

module SimpleGl
  class GlutContext
    # Delegates underscored ruby-style methods to standard camelcased OpenGL
    # ones.
    #
    # Example:
    #
    #   matrix_mode(GL_PROJECTION) # => GL.MatrixMode(GL_PROJECTION)
    #   ortho(1, 2, 3, 4, 5, 6)    # => GL.Ortho(1, 2, 3, 4, 5, 6)
    #   load_identity              # => GL.LoadIdentity
    def method_missing(m, *args, &block)
      Glut.send("glut#{camel_case(m)}", *args, &block)
    end

    private

    def camel_case(string)
      string.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }
    end
  end
end
