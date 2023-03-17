return {
	package = require('./package.lua'),
	CDN = require('CDN'),
	API = require('API'),
	Webhook = require('Webhook/Webhook'),
	User = require('classes/User'),
	Message = require('classes/Message'),
	Guild = require('classes/Guild'),
	EmbedBuilder = require('classes/EmbedBuilder'),
	Embed = require('structures/Embed'),
	enum = require('structures/enum'),
	WebhookTypes = require('enums/WebhookTypes'),
	EmbedTypes = require('enums/EmbedTypes')
}