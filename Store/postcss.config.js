module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}

var tailwindcss = require('tailwindcss');
module.exports = {
  plugins: [
    // ...
    tailwindcss('./app/javascript/src/tailwind.js'),
    require('autoprefixer'),
    // ...
  ]
}
