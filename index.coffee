through = require 'through2'
PluginError = require('gulp-util').PluginError

module.exports = (checks = {}) ->
    stream = through.obj (file, enc, cb) ->
        content = file.contents.toString()
        errors = []
        errors.push(msg) for msg, test of checks when test(content)
        if errors.length
            msg = "in file #{ file.path }:\n - #{ errors.join('\n - ') }"
            throw new PluginError 'gulp-sniffer', msg
        @push file
        return cb()
    return stream
