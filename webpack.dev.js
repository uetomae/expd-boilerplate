const merge = require('webpack-merge')
const common = require('./webpack.common.js')
const path = require('path')

module.exports = merge(common, {
  mode: 'development',
  devServer: {
    https: false,
    host: '0.0.0.0',
    port: 3035,
    sockPort: 443,
    publicPath: 'http://0.0.0.0:3035/public/assets/',
    contentBase: path.resolve(__dirname, 'public/assets/'),
    hot: true,
    disableHostCheck: true,
    historyApiFallback: true,
    watchOptions: {
      poll: true
    },
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': '*'
    }
  }
})
