require "mobtexting_sms/version"
require 'open-uri'
require 'net/http'
require 'net/https'

module MobtextingSms
	class Error < StandardError; end

	class Client
		def initialize(access_token)
			@access_token = access_token
		end
		def send(to, from, body, service)
			api_endpoint = 'https://portal.mobtexting.com/api/v2/'
			url = api_endpoint + 'sms/send?access_token=' + @access_token + '&message=' \
			    + body  + '&sender='+ from + '&to=' + to + '&service=' + service

			return open(url).read
		end
	end

	class Verify
		def initialize(access_token)
			@access_token = access_token
		end
		def send(to)
			api_endpoint = 'https://portal.mobtexting.com/api/v2/'
			url = api_endpoint + 'verify?to=' + to

			url = URI.parse(url)
			https = Net::HTTP.new(url.host,url.port)
			https.use_ssl = true
			req = Net::HTTP::Post.new(url)

			req['Accept'] = 'application/json'
			req['Authorization'] = @access_token
			res = https.request(req)

			return res.body
		end
	end

end
