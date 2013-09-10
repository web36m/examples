module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    remotefile:
      redactor_css:
        url: 'http://imperavi.com/js/redactor/redactor.css'
        dest:'tmp/admin/redactor.css'
      redactor_js:
        url: 'http://imperavi.com/js/redactor/redactor.js'
        dest:'tmp/admin/redactor.js'

    coffee:
      public:
        options:
          bare: true
        files:
          'tmp/public/project.js': [
            'coffee/public/app.coffee'
            'coffee/public/controllers/*.coffee'
            'coffee/public/directives/*.coffee'
            'coffee/public/filters/*.coffee'
            'coffee/public/services/*.coffee'
          ]
      admin:
        options:
          bare: true
        files:
          'tmp/admin/project.js': [
            'coffee/admin/app.coffee'
            'coffee/admin/controllers/*.coffee'
            'coffee/admin/directives/*.coffee'
            'coffee/admin/filters/*.coffee'
            'coffee/admin/services/*.coffee'
          ]
      server:
        options:
          bare: true
        files: [
          expand: true,
          src: '**/*.coffee'
          dest: 'dist/'
          ext: '.js'
          cwd: 'coffee/server/'
        ]

    jade:
      dev_public:
        options:
          debug: true
          pretty: true
          data:
            isDebug: true
            pageTitle: '<%= pkg.name %>'

        files: [
          expand: true,
          src: '**/*.jade'
          dest: 'public/'
          ext: '.html'
          cwd: 'jade/public/'
        ]

      dist_public:
        options:
          debug: false
          pretty: false
          data:
            isDebug: false
            pageTitle: '<%= pkg.name %>'

        files: [
          expand: true,
          src: '**/*.jade'
          dest: 'public/'
          ext: '.html'
          cwd: 'jade/public/'
        ]

    sass:
      public:
        files:
          'tmp/public/vendor.css': 'sass/public/vendor-import.scss'
          'tmp/public/project.css': 'sass/public/project-import.sass'

      admin:
        files:
          'tmp/admin/vendor.css': 'sass/admin/vendor-import.scss'
          'tmp/admin/project.css': 'sass/admin/project-import.sass'

    copy:
      public:
        files: [
          expand: true
          cwd: 'src/font-awesome/font/'
          src: [
            '**'
          ]
          dest: 'public/assets/font/'
        ]
      admin:
        files: [
          expand: true
          cwd: 'src/font-awesome/font/'
          src: [
            '**'
          ]
          dest: 'public/admin/assets/font/'
        ]

    concat:
      options:
        banner: '/*!\n* <%= pkg.name %> v<%= pkg.version %>\n* <%= pkg.description %>\n*\n* Copyright 2012, <%= grunt.template.today(\"yyyy\") %> <%= pkg.author %>\n*\n* Date: <%= (new Date()).toString() %>\n*/\n\n'
      public_vendor_js:
        src: [
          'src/socket.io-client/dist/socket.io.js'
          'src/jquery/jquery.js'
          'src/jquery-ui/ui/jquery-ui.js'
          'src/angular/angular.js'
          'src/angular-ui/build/angular-ui.js'
          'src/angular-resource/angular-resource.js'
          'src/angular-cookies/angular-cookies.js'
          'src/sass-bootstrap/js/bootstrap-collapse.js'
          'src/sass-bootstrap/js/bootstrap-modal.js'
          'src/sass-bootstrap/js/bootstrap-dropdown.js'
          'src/sass-bootstrap/js/bootstrap-tab.js'
          'src/sass-bootstrap/js/bootstrap-tooltip.js'
          'src/sass-bootstrap/js/bootstrap-transition.js'
        ]
        dest: 'tmp/public/vendor.js'
      public_project_js:
        src: [
          'tmp/public/vendor.js'
          'tmp/public/project.js'
        ]
        dest: 'public/assets/js/common.js'
      public_project_css:
        src: [
          'tmp/public/vendor.css'
          'tmp/public/project.css'
        ]
        dest: 'public/assets/css/common.css'
      admin_vendor_js:
        src: [
          'src/socket.io-client/dist/socket.io.js'
          'src/jquery/jquery.js'
          'src/jquery-ui/ui/jquery-ui.js'
          'src/angular/angular.js'
          'src/angular-ui/build/angular-ui.js'
          'src/angular-resource/angular-resource.js'
          'src/angular-cookies/angular-cookies.js'
          'src/sass-bootstrap/js/bootstrap-collapse.js'
          'src/sass-bootstrap/js/bootstrap-modal.js'
          'src/sass-bootstrap/js/bootstrap-dropdown.js'
          'src/sass-bootstrap/js/bootstrap-tab.js'
          'src/sass-bootstrap/js/bootstrap-tooltip.js'
          'src/sass-bootstrap/js/bootstrap-transition.js'
          'src/angular-redactor/angular-redactor.js'
        ]
        dest: 'tmp/admin/vendor.js'
      admin_project_js:
        src: [
          'tmp/admin/vendor.js'
          'tmp/admin/redactor.js'
          'tmp/admin/project.js'
        ]
        dest: 'public/admin/assets/js/common.js'
      admin_project_css:
        src: [
          'tmp/admin/vendor.css'
          'tmp/admin/redactor.css'
          'tmp/admin/project.css'
        ]
        dest: 'public/admin/assets/css/common.css'

    cssmin:
      public:
        expand: true
        cwd: 'public/assets/css/'
        src: [
          '*.css'
          '!*.min.css'
        ]
        dest: 'public/assets/css/'
        ext: '.min.css'
      admin:
        expand: true
        cwd: 'public/admin/assets/css/'
        src: [
          '*.css'
          '!*.min.css'
        ]
        dest: 'public/admin/assets/css/'
        ext: '.min.css'

    uglify:
      public:
        options:
          mangle: false
        files:
          'public/assets/js/common.min.js': '<%= concat.public_project_js.dest %>'
      admin:
        options:
          mangle: false
        files:
          'public/admin/assets/js/common.min.js': '<%= concat.admin_project_js.dest %>'

    develop:
      server:
        file: 'dist/app.js'

    watch:
      options:
        livereload: true
      coffee_public:
        files: [
          'coffee/public/**/*.coffee'
        ]
        tasks: [
          'coffee:public'
          'concat:public_project_js'
        ]
        options:
          nospawn: true
      coffee_admin:
        files: [
          'coffee/admin/**/*.coffee'
        ]
        tasks: [
          'coffee:admin'
          'concat:admin_project_js'
        ]
        options:
          nospawn: true
      coffee_server:
        files: [
          'coffee/server/**/*.coffee'
        ]
        tasks: [
          'coffee:server'
          'develop:server'
        ]
        options:
          nospawn: true
      sass_public:
        files: [
          'sass/public/**/*.sass'
          'sass/public/**/*.scss'
        ]
        tasks: [
          'sass:public'
          'concat:public_project_css'
        ]
        options:
          nospawn: true
      sass_admin:
        files: [
          'sass/admin/**/*.sass'
          'sass/admin/**/*.scss'
        ]
        tasks: [
          'sass:admin'
          'concat:admin_project_css'
        ]
        options:
          nospawn: true
      jade_public:
        files: [
          'jade/public/**/*.jade'
        ]
        tasks: [
          'jade:dev_public'
        ]
        options:
          nospawn: true


  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-develop'
  grunt.loadNpmTasks 'grunt-remotefile'

  grunt.registerTask 'default', [
    'dev'
    'develop:server'
    'watch'
  ]
  grunt.registerTask 'dev', [
    'remotefile'
    'copy'
    'coffee'
    'jade:dev_public'
    'sass'
    'concat:public_vendor_js'
    'concat:admin_vendor_js'
    'concat:public_project_js'
    'concat:public_project_css'
    'concat:admin_project_js'
    'concat:admin_project_css'
  ]
  grunt.registerTask 'prod', [
    'remotefile'
    'copy'
    'coffee'
    'jade:dist_public'
    'sass'
    'concat:public_vendor_js'
    'concat:admin_vendor_js'
    'concat:public_project_js'
    'concat:public_project_css'
    'concat:admin_project_js'
    'concat:admin_project_css'
    'uglify'
    'cssmin'
  ]
