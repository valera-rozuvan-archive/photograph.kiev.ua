/**
 * "Rules of Optimization:
 *     Rule 1: Don't do it.
 *     Rule 2 (for experts only): Don't do it yet.”
 *
 * ~ Michael A. Jackson
 */

(function () {
    require.config({
        baseUrl: 'js',
        shim: {
          isotope: {
            deps: ['jquery'],
            exports: 'Isotope'
          }
        },
        paths: {
            jquery: 'vendor/jquery/jquery.min',
            isotope: 'vendor/isotope/isotope.pkgd.min'
        }
    });

    require(['jquery', 'isotope'], function ($, Isotope) {
      $.noConflict();

      $(document).ready(function () {

        var elem = document.querySelector('.photo-preview-grid');
        var iso = new Isotope( elem, {
          itemSelector: '.photo-preview',
          layoutMode: 'masonry',
          sortBy: 'original-order'
        });

      });
    });
}).call(this);
