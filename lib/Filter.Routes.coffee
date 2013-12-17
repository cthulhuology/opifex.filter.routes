# Filter.Routes.coffee
#
#	© 2013 Dave Goehrig <dave@dloh.org>
#

config = require "#{process.env.HOME}/.routes.coffee"

Routes = () ->
	self = this
	this.init = () ->
		self.connection.exchange config.exchange,  { durable: false, type: 'topic', autoDelete: true }, (Exchange) ->
			self.connection.queue self.queue.name,{ arguments: { "x-message-ttl" : 60000 } }, (Queue) ->
				Queue.bind config.exchange, "#{config.prefix}.#{chan}" for chan in config.channels
	this["*"] = (label, message...) ->
		this.send [ config.message || label ].concat(message), this.dest, this.key

module.exports = Routes
