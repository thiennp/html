_version = 134
_port = 8000
_livereload_port = 35729

lrSnippet = require 'connect-livereload'
    _port: _livereload_port
    mountFolder = (connect, dir) ->
        connect.static require('path').resolve(dir)

module.exports = (grunt) ->
    grunt.initConfig
        clean:
            dist: ['dist/*']

        coffee:
            src:
                expand: true
                cwd: 'src/scripts'
                src: '**/*.coffee'
                dest: 'dist/scripts'
                ext: '.js'

        sass:
            dist:
                files:
                    'dist/main.css': ['src/**/*.scss']

        jade:
            index:
                options:
                    data:
                        debug: true
                    pretty: true
                files:
                    'dist/index.html': ['src/templates/index.jade']
            templates:
                options:
                    data:
                        debug: true
                    pretty: true
                files: [{
                    cwd: "src/templates"
                    src: "**/*.jade"
                    dest: "dist/templates"
                    expand: true
                    ext: ".html"
                }]

        copy:
            vendors:
                expand: true
                cwd: 'bower_components'
                src: ['**/*.js','**/*.css','**/*.ttf','**/*.woff','**/*.svg','**/*.eot','**/*.png','**/*.jpg','**/*.jpeg','**/*.map']
                dest: 'dist/vendors/'
            app:
                expand: true
                cwd: 'src'
                src: ['**/*.js','**/*.css','**/*.ttf','**/*.woff','**/*.svg','**/*.eot','**/*.png','**/*.jpg','**/*.jpeg','**/*.map']
                dest: 'dist/'

        watch:
            option:
                files: 'src/**/*.*'
                tasks: ['clean', 'coffee', 'sass', 'jade', 'copy']
                options:
                    livereload: _livereload_port

        connect:
            server:
                options: 
                    port: _port
                    hostname: '0.0.0.0'
                    base: 'dist'
                livereload:
                    options:
                        middleware: (connect) ->
                            [lrSnippet, mountFolder(connect, './')]

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-open'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-connect'

    grunt.registerTask 'default', ['clean', 'coffee', 'sass', 'jade', 'copy', 'connect', 'watch']
    grunt.registerTask 'build', ['clean', 'coffee', 'sass', 'jade', 'copy']