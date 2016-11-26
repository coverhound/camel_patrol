require 'test_helper'

describe CamelPatrol::Middleware do
  subject { CamelPatrol::Middleware }

  describe 'on request' do
    let(:incoming) { {} }
    let(:params) do
      {
        'dwelling' => { 'squareFootage' => 5000 }
      }
    end

    if Rails::VERSION::MAJOR < 5
      let(:env_params) do
        { 'action_dispatch.request.request_parameters' => params }
      end
      let(:app) do
        proc do
          incoming[:params] = env['action_dispatch.request.request_parameters']
          [200, {}, ['{}']]
        end
      end
    else
      let(:env_params) do
        { 'rack.input' => StringIO.new(params.to_json) }
      end
      let(:app) do
        proc do
          incoming[:params] = JSON.parse(env['rack.input'].read)
          [200, {}, ['{}']]
        end
      end
    end

    before do
      subject.new(app).call(env)
    end

    describe 'when content-type JSON' do
      let(:env) do
        env_params.merge('CONTENT_TYPE' => 'application/json; charset=utf-8')
      end

      it 'snake_cases the params' do
        assert_nil incoming[:params]['dwelling']['squareFootage']
        refute_nil incoming[:params]['dwelling']['square_footage']
      end
    end

    describe 'when content-type not JSON' do
      let(:env) do
        env_params.merge('CONTENT_TYPE' => 'text/plain; charset=utf-8')
      end

      it 'does nothing' do
        refute_nil incoming[:params]['dwelling']['squareFootage']
        assert_nil incoming[:params]['dwelling']['square_footage']
      end
    end
  end

  describe 'on response' do
    let(:app) do
      proc { [200, headers, [body]] }
    end
    let(:body) { '{"dwelling":{"square_footage":5000}}' }
    let(:request) { Rack::MockRequest.new(subject.new(app)) }

    describe 'when content-type JSON' do
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it 'camelCases the response' do
        response = request.get('/')
        json = JSON.parse(response.body)

        refute_nil json['dwelling']['squareFootage']
        assert_nil json['dwelling']['square_footage']
      end
    end

    describe 'when content-type not JSON' do
      let(:headers) { { 'Content-Type' => 'text/plain' } }

      it 'does nothing' do
        response = request.get('/')
        json = JSON.parse(response.body)

        assert_nil json['dwelling']['squareFootage']
        refute_nil json['dwelling']['square_footage']
      end
    end

    describe 'when given invalid JSON' do
      let(:headers) { { 'Content-Type' => 'application/json' } }
      let(:body) { '{"dwelling":{"square_footage":5000}' }

      it 'does nothing' do
        response = request.get('/')
        assert_match(/square_footage/, response.body)
      end
    end
  end
end
