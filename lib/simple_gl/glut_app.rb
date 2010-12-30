require 'opengl'
require 'simple_gl/gl_context'

module SimpleGl
  include Glu,Glut

  class GlutApp
    def initialize(&block)
      @gl = GlContext.new

      instance_eval &block
    end

    def start
      glutInit

      instance_eval &@init_proc

      glutDisplayFunc(@display_proc)
      glutKeyboardFunc(@keyboard_proc)
      glutReshapeFunc(@reshape_proc)
    end

    def main_loop
      glutMainLoop
    end

    module Callbacks
      def init(&block)
        @init_proc = block
      end

      def display(&block)
        @display_proc = block
      end

      def keyboard(&block)
        @keyboard_proc = block
      end

      def reshape(&block)
        @reshape_proc = block
      end
    end

    include Callbacks
  end
end
