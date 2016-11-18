module CamelPatrol
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      underscore_params(env) if json?(env["CONTENT_TYPE"])

      @app.call(env).tap do |_status, headers, response|
        camelize_response(response) if json?(headers["Content-Type"])
      end
    end

    private

    def underscore_params(env)
      if ::Rails::VERSION::MAJOR < 5
        env["action_dispatch.request.request_parameters"].deep_transform_keys!(&:underscore)
      else
        request_body = JSON.parse(env["rack.input"].read)
        request_body.deep_transform_keys!(&:underscore)
        req = StringIO.new(request_body.to_json)

        env["rack.input"] = req
        env["CONTENT_LENGTH"] = req.length
      end
    end

    def camelize_response(response)
      response.each do |body|
        new_response = safe_json_parse(body) or next
        new_response.deep_transform_keys! { |key| key.camelize(:lower) }
        body.replace(new_response.to_json)
      end
    end

    def safe_json_parse(body)
      JSON.parse(body)
    rescue JSON::ParserError
      nil
    end

    def json?(content_type)
      # WARNING:
      # We"re using substring matching over Regexp intentionally - Middleware is a hot path and
      # this will be checked on every request
      content_type && content_type.include?("application/json")
    end
  end
end
