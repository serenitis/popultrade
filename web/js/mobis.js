/*!
 * jQuery MobiScroll v1.6
 * http://mobiscroll.com
 *
 * Copyright 2010-2011, Acid Media
 * Licensed under the MIT license.
 *
 */
(function ($) {

    function Dlist(elm, dw, settings) {
        var that = this,
            s = settings,
            yOrd,
            mOrd,
            dOrd,
            iv = {},
            tv = {},
            visible = false;

        this.settings = s;
        this.values = null;
        this.val = null;
        // Temporary values
        this.temp = null;

        /**
        * Set settings for all instances.
        * @param {Object} o - New default settings.
        */
        this.setDefaults = function(o) {
            $.extend(defaults, o);
        }

        /**
        * Enables the dlist and the associated input.
        */
        this.enable = function() {
            s.disabled = false;
            if ($(elm).is(':input'))
                $(elm).prop('disabled', false);
        }

        /**
        * Scrolls target to the specified position
        * @param {Object} t - Target wheel jQuery object.
        * @param {Number} val - Value.
        * @param {Number} [time] - Duration of the animation, optional.
        */
        this.scroll = function(t, val, time, orig, index) {
            //t.data('pos', val)
            t.attr('style', (time ? (prefix + '-transition:all ' + time.toFixed(1) + 's ease-out;') : '') + (has3d ? (prefix + '-transform:translate3d(0,' + (val * h) + 'px,0);') : ('top:' + (val * h) + 'px;')));

            function getVal(t, b, c, d) {
                return c * Math.sin(t/d * (Math.PI/2)) + b;
            }

            if (time) {
                var i = 0;
                clearInterval(iv[index]);
                iv[index] = setInterval(function() {
                    i += 0.1;
                    t.data('pos', Math.round(getVal(i, orig, val - orig, time)));
                    if (i >= time) {
                        clearInterval(iv[index]);
                        t.data('pos', val);
                    }
                }, 100);
                // Show +/- buttons
                clearTimeout(tv[index]);
                tv[index] = setTimeout(function() {
                    if (!t.hasClass('dwa'))
                        t.closest('.dwwl').find('.dwwb').fadeIn('fast');
                }, time * 1000);
            }
            else {
                t.data('pos', val)
            }
        }

        /**
        * Disables the dlist and the associated input.
        */
        this.disable = function() {
            s.disabled = true;
            if ($(elm).is(':input'))
                $(elm).prop('disabled', true);
        }

        /**
        * Format a date into a string value with a specified format.
        * @param {String} format - Output format.
        * @param {Date} date - Date to format.
        * @param {Object} settings - Settings.
        * @return {String} - Returns the formatted date string.
        */
      

        /**
        * Extract a date from a string value with a specified format.
        * @param {String} format - Input format.
        * @param {String} value - String to parse.
        * @param {Object} settings - Settings.
        * @return {Date} - Returns the extracted date.
        */
        /**
        * Gets the selected wheel values, formats it, and set the value of the dlist instance.
        * If input parameter is true, populates the associated input element.
        * @param {Boolean} [input] - Also set the value of the associated input element. Default is true.
        */
        this.setValue = function (input) {
         /*   if (input == undefined) input = true;
            var v = "xd";//this.formatResult();
            this.val = v;
            this.values = this.temp.slice(0);
            if (input && $(elm).is(':input')) $(elm).val(v).change();*/
        }

        /**
        * Returns the currently selected date.
        * @return {Date}
        */


        /**
        * Sets the selected date
        * @param {Date} d - Date to select.
        * @param {Boolean} [input] - Also set the value of the associated input element. Default is true.
        */


        /**
        * Extracts the selected wheel values form the string value.
        * @param {String} val - String to parse.
        * @return {Array} Array with the selected wheel values.
        */
      

        /**
        * Formats the selected wheel values form the required format.
        * @return {String} Formatted string.
        */

        /**
        * Checks if the current selected values are valid together.
        * In case of date presets it checks the number of days in a month.
        * @param {Integer} i - Currently changed wheel index, -1 if initial validation.
        */
  

        /**
        * Hides the dlist instance.
        */
        this.hide = function () {
            // If onClose handler returns false, prevent hide
        	//alert(6);
            if (s.onClose(this.val, this) === false) return false;
            // Re-enable temporary disabled fields
            //alert(16);
            $('.dwtd').prop('disabled', false).removeClass('dwtd');
            //alert(17);
           // $(elm).blur();
            // Hide wheels and overlay
            //alert(116);
            dw.hide();
            dwo.hide();
            //alert(62);
            visible = false;
            if (this.preset)
                s.wheels = null;
            // Stop positioning on window resize
            $(window).unbind('resize.dw');
        }

        /**
        * Shows the dlist instance.
        */
        
        //// prikaz inputa
        var prikaz = false;
        
        this.show = function () {
            if (s.disabled || visible) return false;

            s.beforeShow(elm, this);
            // Set global wheel element height
            h = s.height;
            m = Math.round(s.rows / 2);

            inst = this;

          //  this.init();

         


            // Set dlists to position
    
            // Set value text
         //   if (s.showValue)
              //  $('.dwv', dw).html(this.formatResult()).show();
          //  else
           //     $('.dwv', dw).hide();
            // Initial validate
         //   that.validate(-1);

            // Init buttons
            $('#dw_set', dw).text(s.setText).unbind().bind('click', function (e) {
                //alert(1);
            	that.setValue();
                
                s.onSelect(that.val, inst);
                that.hide();
                //alert(20);
                return false;
            });

            $('#dw_cancel', dw).text(s.cancelText).unbind().bind('click', function (e) {
                s.onCancel(that.val, inst);
                that.hide();
                return false;
            });
            

            // Disable inputs to prevent bleed through (Android bug)
            $(':input:not(:disabled)').addClass('dwtd');
            $(':input').prop('disabled', true);
            // Show
           // alert(((elm.onkeyup+"").substring((elm.onkeyup+"").indexOf("{")+1,(elm.onkeyup+"").lastIndexOf("}"))).replace("document.dod."+elm.name+".value","document.getElementById('"+elm.name+"_vre').value"));
                        
            if (elm.onkeyup!='undefined') {
            	
            	try {
    				smoll.remove();
    				}
    				catch ( e) {
    					
    				}
            	
            	if (prikaz) {
            		smol.remove();
            	}
            	//else {
            	 smol = $('<input type=text class="inputIExt" onkeyup="'+((elm.onkeyup+"").substring((elm.onkeyup+"").indexOf("{")+1,(elm.onkeyup+"").lastIndexOf("}"))).replace("document.dod."+elm.name+".value","this.value")+'" id="'+elm.name+'_vre" name="'+elm.name+'_vre" size=23 value="'+elm.value+'">').appendTo(".dwv");
            	prikaz=true;
            	//}
            	 //alert(1);     
            }            
           
            
            
            dwo.show();
            dw.attr('class', 'dw ' + s.theme).show();
            visible = true;
            // Set sizes
            $('.dww, .dwwl', dw).height(s.rows * h);
            $('.dww', dw).each(function() { $(this).width($(this).parent().width() < s.width ? s.width : $(this).parent().width()); });
            $('.dwbc a', dw).attr('class', s.btnClass);
            $('.dww li, .dwwb', dw).css({
                height: h,
                lineHeight: h + 'px'
            });
            $('.dwwc', dw).each(function() {
                var w = 0;
                $('.dwwl', this).each(function() { w += $(this).outerWidth(true); });
                $(this).width(w);
            });
            $('.dwc', dw).each(function() {
                $(this).width($('.dwwc', this).outerWidth(true));
            });
            // Set position
            this.pos();
            $(window).bind('resize.dw', function() { that.pos(); });
        }

        /**
        * Positions the dlist instance to the center of the viewport.
        */
        this.pos = function() {
            var totalw = 0,
                minw = 0,
                ww = $(window).width(),
                wh = $(window).height(),
                st = $(window).scrollTop(),
                w,
                h;
            $('.dwc', dw).each(function() {
                w = $(this).outerWidth(true);
                totalw += w;
                minw = (w > minw) ? w : minw;
            });
            w = totalw > ww ? minw : totalw;
            dw.width(450);
            w = dw.outerWidth();
            h = dw.outerHeight();
            dw.css({ left: (ww - w) / 2, top: st + (wh - h) / 2 });
            dwo.height(0);
            dwo.height($(document).height());
        }

        /**
        * Dlist initialization.
        */
        this.init = function() {
            // Set year-month-day order
            var ty = s.dateOrder.search(/y/i),
                tm = s.dateOrder.search(/m/i),
                td = s.dateOrder.search(/d/i);
            yOrd = ty < tm ? (ty < td ? 0 : 1) : (ty < td ? 1 : 2);
            mOrd = tm < ty ? (tm < td ? 0 : 1) : (tm < td ? 1 : 2);
            dOrd = td < ty ? (td < tm ? 0 : 1) : (td < tm ? 1 : 2);
            this.preset = (s.wheels === null);
            this.temp = "";//(($(elm).is('input') && this.val !== null && this.val != $(elm).val()) || this.values === null) ? this.parseValue($(elm).val() ? $(elm).val() : '') : this.values.slice(0);
            this.setValue(false);
        }

        this.init();

        // Set element readonly, save original state
        if ($(elm).is(':input') && s.showOnFocus)
            $(elm).data('dwro', $(elm).prop('readonly')).prop('readonly', true);

        // Init show datewheel
        $(elm).addClass('dlist').unbind('focus.dw').bind('focus.dw', function (e) {
            if (s.showOnFocus)
                that.show();
        });
    }

    function testProps(props) {
        for (var i in props) {
            if (mod[props[i]] !== undefined ) {
                return true;
            }
        }
        return false;
    }

    function testPrefix() {
        var prefixes = ['Webkit', 'Moz', 'O', 'ms'];
        for (var p in prefixes) {
            if (testProps([prefixes[p] + 'Transform']))
                return '-' + prefixes[p].toLowerCase();
        }
        return '';
    }

    var dw,
        dwo,
        h,
        m,
        l,
        inst, // Current instance
        dlists = {}, // Dlist instances
        date = new Date(),
        uuid = date.getTime(),
        move = false,
        target = null,
        start,
        stop,
        startTime,
        endTime,
        pos,
        mod = document.createElement(mod).style,
        has3d = testProps(['perspectiveProperty', 'WebkitPerspective', 'MozPerspective', 'OPerspective', 'msPerspective']) && 'webkitPerspective' in document.documentElement.style,
        prefix = testPrefix(),
        touch = ('ontouchstart' in window),
        START_EVENT = touch ? 'touchstart' : 'mousedown',
        MOVE_EVENT = touch ? 'touchmove' : 'mousemove',
        END_EVENT = touch ? 'touchend' : 'mouseup',
        defaults = {
            // Options
            width: 80,
            height: 40,
            rows: 3,
            disabled: false,
            showOnFocus: true,
            showValue: true,
            showLabel: true,
            wheels: null,
            theme: '',
            mode: 'dlist',
            preset: 'date',
            dateFormat: 'mm/dd/yy',
            dateOrder: 'mmddy',
            ampm: true,
            seconds: false,
            timeFormat: 'hh:ii A',
            startYear: date.getFullYear() - 100,
            endYear: date.getFullYear() + 5,
            monthNames: ['January','February','March','April','May','June', 'July','August','September','October','November','December'],
            monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
            dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
            shortYearCutoff: '+10',
            monthText: 'Month',
            dayText: 'Day',
            yearText: 'Year',
            hourText: 'Hours',
            minuteText: 'Minutes',
            secText: 'Seconds',
            ampmText: '&nbsp;',
            setText: 'Set',
            cancelText: 'Cancel',
            btnClass: 'dwb',
            stepHour: 1,
            stepMinute: 1,
            stepSecond: 1,
            // Events
            beforeShow: function() {},
            onClose: function() {},
            onSelect: function() {},
            onCancel: function() {},
   
            validate: function() {
                return true;
            }
        },

        methods = {
            init: function (options) {
                if (options === undefined) options = {};
                var defs = {};
                //options.mode = $.inArray(options.mode, ['dlist', 'clickpick', 'mixed']) == -1 ? 'dlist' : options.mode;
                // Skin dependent defaults
                switch (options.theme) {
                    case 'ios':
                        defs.dateOrder = 'MMdyy';
                        defs.rows = 5;
                        defs.height = 30;
                        defs.width = 55;
                        defs.showValue = false;
                        defs.showLabel = false;
                        break;
                    case 'android':
                        defs.dateOrder = 'Mddyy';
                        break;
                    case 'android-ics':
                    case 'android-ics light':
                        defs.dateOrder = 'Mddyy';
                        defs.rows = 5;
                        defs.width = 70;
                        defs.showLabel = false;
                        defs.mode = 'mixed';
                        break;
                }
                // Mode dependent defaults
                if (options.mode == 'clickpick') {
                    defs.height = 50;
                    defs.rows = 3;
                }

                var settings = $.extend({}, defaults, defs, options),
                    plustap = false,
                    minustap = false;

               // if ($('.dw').length) {
                 //   dwo = $('.dwo');
                //    dw = $('.dw');
               // }
                if (true) {
                    // Create html
                    dwo = $('<div class="dwo">cdcsdcsdcsdcdscsd</div>').hide().appendTo('body');
                    dw = $('<div class="dw">' +
                        '<div class="dwv" id="dwv">&nbsp;</div>' +
                        '<div class="dwbc" style="clear:both;">' +
                            '<span class="dwbw dwb-s"><a id="dw_set" href="#"></a></span>' +
                            '<span class="dwbw dwb-c"><a id="dw_cancel" href="#"></a></span>' +
                        '</div>' +
                    '</div>');

                    dw.hide().appendTo('body');

                    function getY(e) {
                        return touch ? e.originalEvent.changedTouches[0].pageY : e.pageY;
                    }

               

                    function plus(t) {
                        if (plustap) {
                            var p = t.data('pos'),
                                val = p - 1;
                            val = val < (m - l) ? (m - 1) : val;
                            calc(t, val);
                        }
                        else {
                            clearInterval(plustap);
                        }
                    }

                    function minus(t) {
                        if (minustap) {
                            var p = t.data('pos'),
                                val = p + 1;
                            val = val > (m - 1) ? (m - l) : val;
                            calc(t, val);
                        }
                        else {
                            clearInterval(minustap);
                        }
                    }

                    $(document).bind(MOVE_EVENT, function (e) {
                        if (move) {
                            e.preventDefault();
                            stop = getY(e);

                            // Circular wheels
                            /*var diff = Math.round((stop - start) / h);
                            if (diff > 0) {
                                start += h;
                                $('li:last', target).prependTo(target);
                            }
                            else if (diff < 0) {
                                start -= h;
                                $('li:first', target).appendTo(target);
                            }*/
                            var val = pos + (stop - start) / h;
                            val = val > (m - 1 + 1) ? (m - 1 + 1) : val;
                            val = val < (m - l - 1) ? (m - l - 1) : val;
                            inst.scroll(target, val);
                        }
                    });

                    $(document).bind(END_EVENT, function (e) {
                        if (move) {
                            e.preventDefault();
                            target.removeClass('dwa');
                            var time = new Date() - startTime,
                                val = pos + (stop - start) / h;
                            val = val > (m - 1 + 1) ? (m - 1 + 1) : val;
                            val = val < (m - l - 1) ? (m - l - 1) : val;

                            if (time < 300) {
                                var speed = (stop - start) / time;
                                var dist = (speed * speed) / (2 * 0.0006);
                                if (stop - start < 0) dist = -dist;
                            }
                            else {
                                var dist = stop - start;
                            }
                            //var dist = stop - start;
                            calc(target, Math.round(pos + dist / h), true, Math.round(val));
                            move = false;
                            target = null;
                        }
                        clearInterval(plustap);
                        clearInterval(minustap);
                        plustap = false;
                        minustap = false;
                        $('.dwb-a').removeClass('dwb-a');
                    });

                    dw.delegate('.dwwl', 'DOMMouseScroll mousewheel', function (e) {
                        e.preventDefault();
                        e = e.originalEvent;
                        var delta = e.wheelDelta ? (e.wheelDelta / 120) : (e.detail ? (-e.detail / 3) : 0),
                            t = $('ul', this),
                            p = t.data('pos'),
                            val = Math.round(p + delta);
                        l = $('li:visible', t).length;

                        // Circular wheels
                        /*if (p > val) {
                            val += 40;
                            $('li:first', t).appendTo(t);
                        }
                        else if (p < val) {
                            val -= 40;
                            $('li:last', t).prependTo(t);
                        }*/
                        calc(t, val);
                    }).delegate('.dwb, .dwwb', START_EVENT, function (e) {
                        // Active button
                        $(this).addClass('dwb-a');
                    }).delegate('.dwwbp', START_EVENT, function (e) {
                        // + Button
                        e.preventDefault();
                        e.stopPropagation();
                        var t = $(this).closest('.dwwl').find('ul');
                        l = $('li:visible', t).length;
                        clearInterval(plustap);
                        plustap = setInterval(function() { plus(t); }, 300);
                        plus(t);
                    }).delegate('.dwwbm', START_EVENT, function (e) {
                        // - Button
                        e.preventDefault();
                        e.stopPropagation();
                        var t = $(this).closest('.dwwl').find('ul');
                        l = $('li:visible', t).length;
                        clearInterval(minustap);
                        minustap = setInterval(function() { minus(t); }, 300);
                        minus(t);
                    }).delegate('.dwwl', START_EVENT, function (e) {
                        // Scroll start
                        if (!move && inst.settings.mode != 'clickpick') {
                            e.preventDefault();
                            move = true;
                            target = $('ul', this).addClass('dwa');
                            $('.dwwb', this).fadeOut('fast');
                            pos = target.data('pos');
                            l = $('li:visible', target).length;
                            start = getY(e);
                            startTime = new Date();
                            stop = start;
                            inst.scroll(target, pos);
                        }
                    });
                }

                return this.each(function () {
                    if (!this.id) {
                        uuid += 1;
                        this.id = 'scoller' + uuid;
                    }
                    dlists[this.id] = new Dlist(this, dw, settings);
                });
            },
            enable: function() {
                return this.each(function () {
                    if (dlists[this.id]) dlists[this.id].enable();
                });
            },
            disable: function() {
                return this.each(function () {
                    if (dlists[this.id]) dlists[this.id].disable();
                });
            },
            isDisabled: function() {
                if (dlists[this[0].id])
                    return dlists[this[0].id].settings.disabled;
            },
            option: function(option, value) {
                return this.each(function () {
                    if (dlists[this.id]) {
                        if (typeof option === 'object')
                            $.extend(dlists[this.id].settings, option);
                        else
                            dlists[this.id].settings[option] = value;
                        dlists[this.id].init();
                    }
                });
            },
            setValue: function(d, input) {
                if (input == undefined) input = false;
                return this.each(function () {
                    if (dlists[this.id]) {
                        dlists[this.id].temp = d;
                        dlists[this.id].setValue(d, input);
                    }
                });
            },
            getValue: function() {
                if (dlists[this[0].id])
                    return dlists[this[0].id].values;
            },
            setDate: function(d, input) {
                if (input == undefined) input = false;
                return this.each(function () {
                    if (dlists[this.id]) {
                        dlists[this.id].setDate(d, input);
                    }
                });
            },
            getDate: function() {
                if (dlists[this[0].id])
                    return dlists[this[0].id].getDate();
            },
            show: function() {
                if (dlists[this[0].id])
                    return dlists[this[0].id].show();
            },
            hide: function() {
                return this.each(function () {
                   ////alert(11);
                	if (dlists[this.id])
                    	////alert(2);
                        dlists[this.id].hide();
                });
            },
            destroy: function() {
                return this.each(function () {
                    if (dlists[this.id]) {
                        $(this).unbind('focus.dw').removeClass('dlist');
                        if ($(this).is(':input'))
                            $(this).prop('readonly', $(this).data('dwro'));
                        delete dlists[this.id];
                    }
                });
            }
        };

    $.fn.dlist = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        }
        else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        }
        else {
            $.error('Unknown method');
        }
    }

    $.dlist = new Dlist(null, null, defaults);

})(jQuery);
