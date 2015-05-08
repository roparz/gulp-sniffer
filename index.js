var PluginError, through;

through = require('through2');

PluginError = require('gulp-util').PluginError;

module.exports = function(checks) {
  var _throw, stream;
  if (checks == null) {
    checks = {};
  }
  _throw = function(msg) {
    throw new PluginError('gulp-sniffer', msg);
  };
  stream = through.obj(function(file, enc, cb) {
    var content, msg, test;
    content = file.contents.toString();
    for (msg in checks) {
      test = checks[msg];
      if (test(content)) {
        _throw(msg);
      }
    }
    this.push(file);
    return cb();
  });
  return stream;
};
