module.exports = {
    content: [
        './app/views/**/*.erb',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js'
    ],
    theme: {
        extend: {
            colors: {
                'blue': {
                    900: '#0747a6',
                }
            }
        }
    },
    plugins: [],
}