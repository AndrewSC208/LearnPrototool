const path = require('path');

module.exports = {
  entry: './PB_MODULE_NAME.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'PB_MODULE_NAME.js'
  }
};