module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    shell:
      test_execute:
        options:
          stdout: true
        command: 'php path/www/index.php cron test_execute'
    watch:
      options:
        livereload: true
      php:
        files: [
          'path/**/*.php'
        ]
        tasks: [
          'shell'
        ]

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.registerTask 'default', [
    'watch'
  ]
