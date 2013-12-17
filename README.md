Opifex.filter.routes
====================

Creates a multiple routing key filter based on a common routing key scheme

Getting Started:
----------------

	opifex 'amqp://guest:guest@localhost:5672//route-in/#/router/route-out/router' filter.routes

This will read a config file in ~/.routes.coffee:

	module.exports =
		exchange: "filtered-exchange"
		prefix: "routing.key.prefix"
		channels: [ "suffix1","suffix2", ... "suffixN" ]
		message: "out-bound-message-name"

So assuming your inbound messages have a routing key of the form:

	"#{prefix}.#{channel}"

This module will create a series of bindings of a set of key suffixes from a single exchange, to it's queue.

The module will then rewrite the message and send it to the commandline specified outbound exchange.
