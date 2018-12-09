module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @path_regexp = my_path_regexp
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path_match?(path)
      end

      def my_path_regexp
        path_parts = @path.split('/')
        path_parts.map! do |part|
          if part[0] == ":"
            part.delete!(':')
            /\w+/
          else
            part
          end
        end
        str_regexp = path_parts.join("\\/")
        /#{str_regexp}$/
      end

      def path_match?(path)
        path.match(@path_regexp)
      end

      def path_params(env)
        path = env['PATH_INFO']

        path_parts = split_path(@path)
        path_parts_requested = split_path(path)

        path_parts.each.with_index.with_object({}) do |(path_part, index), params|
          if path_part[0] == ":"
            path_part.delete!(':')
            params[path_part.to_sym] = path_parts_requested[index]
          end
        end
      end

      def split_path(path)
        path.split('/').reject(&:empty?)
      end

    end
  end
end
