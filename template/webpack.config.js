const path = require('path');

module.exports = {
  entry: './users_pb.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'users_pb.js'
  }
};