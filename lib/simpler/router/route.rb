module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path_match?(path)
      end

      def path_replace(path_parts)
        path_parts.map! do |part|
          if part[0] == ":"
            part = /\d/
          else
            part
          end
        end

        path_parts
      end


      def path_match?(path)
        if @path.include?(':')
          path_parts = split_path(@path)
          path_parts_requested = split_path(path)

          path_replace(path_parts)

          path_parts.each_with_index do |path_part, index|
            return false if path_part.match(path_parts_requested[index]).nil?
          end

        else
          path.match(@path)
        end
      end

      def split_path(path)
        path.split('/').reject!(&:empty?)
      end

      def path_params(env)
        path = env['PATH_INFO']

        path_parts = split_path(@path)
        path_parts_requested = split_path(path)

        params = Hash.new

        path_parts.each_with_index do |path_part, index|
          if path_part[0] == ":"
            path_part.delete!(':')
            params[path_part.to_sym] = path_parts_requested[index]
          end
        end

        env['simpler.path_params'] = params
      end

    end
  end
end
