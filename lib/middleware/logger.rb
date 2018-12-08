require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    @logger.info logger_message(env, status, headers)

    [status, headers, body]
  end

  def logger_message(env, status, headers)

    message_line = "\nRequest: #{env["REQUEST_METHOD"]} "
    message_line << env["PATH_INFO"]

    if env['simpler.controller']
      message_line << "\nParameters: #{env['simpler.controller'].params}"
    end

    message_line << "\nHandler: #{env['simpler.handler']}"

    message_line << "\nResponse: #{status} "
    message_line << "[#{headers['Content-Type']}]"
    message_line << " #{env['simpler.template']}"

  end
end
