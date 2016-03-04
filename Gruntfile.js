'use strict';

//var markdown = require('node-markdown').Markdown;
//var fs = require('fs');

module.exports = function(grunt) {
    //change coffeescript to js
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-angular-templates');

    grunt.initConfig({
        coffee: {
            compile: {
                files: {
                    'release/date-period-picker.js': ['src/*.coffee'],
                }
            }
        },
        jade: {
            compile: {
                files: {
                    "release/datepicker-modal.html": "src/datepicker-modal.jade",
                    "release/mg-datepicker.html": "src/mg-datepicker.jade"
                }
            }
        },
        sass: {                              // Task
            compile: {                            // Target
                files: {                         // Dictionary of files
                    'release/datepicker-modal.css': 'src/datepicker-modal.scss',       // 'destination': 'source'
                    'release/mg-datepicker.css': 'src/mg-datepicker.scss'
                }
            }
        },
        ngtemplates: {
            datePeriodPicker: {
                src: 'release/*.html',
                dest: 'release/date-period-picker-templates.js'
            }
        }
    });

    grunt.registerTask('default', ["jade", "coffee", "sass", "ngtemplates"]);

    return grunt;
};


