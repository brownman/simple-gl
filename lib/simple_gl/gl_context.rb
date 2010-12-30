require 'opengl'
require 'simple_gl/constants'

module SimpleGl
  # Provides an interface to the standard GL module with a little syntax sugar on
  # top. A good example is the +begin+ method, which wraps glBegin and glEnd
  # calls by yielding to a ruby block.
  class GlContext
    include Constants

    def clear
      GL.Clear(GL_COLOR_BUFFER_BIT)
    end

    def color(*args)
      args.map! &:to_f
      GL.Color(*args)
    end

    def point_size=(v)
      GL.PointSize(v.to_f)
    end

    # Wraps glBegin and glEnd methods by yielding between those two calls. Makes
    # consequent drawing code much clearer and more ruby-esque.
    #
    # Example:
    #
    # begin :points do
      #   vertex 1, 2, 3
      #   vertex 2, 3, 4
      # end
      def begin(type, &block)
        GL.Begin(gl_constant(type))

        instance_eval(&block)

        GL.End
      end

      def vertex(*args)
        args.map! &:to_f
        GL.Vertex(*args)
      end

      # Delegates underscored ruby-style methods to standard camelcased OpenGL
      # ones.
      #
      # Example:
      #
      # matrix_mode(GL_PROJECTION) # => GL.MatrixMode(GL_PROJECTION)
      # ortho(1, 2, 3, 4, 5, 6)    # => GL.Ortho(1, 2, 3, 4, 5, 6)
      # load_identity              # => GL.LoadIdentity
      def method_missing(m, *args, &block)
        GL.send(camel_case(m), *args, &block)
      end

      private

      def camel_case(string)
        string.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }
      end
    end
  end
