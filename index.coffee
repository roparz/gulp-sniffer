through = require 'through2'
PluginError = require('gulp-util').PluginError

module.exports = (checks = {}) ->
    _throw = (msg) -> throw new PluginError 'gulp-sniffer', msg
    stream = through.obj (file, enc, cb) ->
        content = file.contents.toString()
        _throw(msg) for msg, test of checks when test(content)
        @push file
        return cb()
    return stream
