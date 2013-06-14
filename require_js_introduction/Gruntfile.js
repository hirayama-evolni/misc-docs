module.exports = function(grunt) {
    var _path = require('path');

    grunt.initConfig({
        coffee: {
            all: {
                options: {
//                    bare: true
                },
                expand: true,
                flatten: true,
                cwd: '.',
                src: ['coffee/*.coffee'],
                dest: 'js/',
                ext: '.js'
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('default', ['coffee']);
};
