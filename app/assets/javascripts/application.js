// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .


$(document).ready(function(){

  // Defining the variables
  var index = 0;
  var $element = $(this);

  // Array of Colours
  var colourArray = [

    // Colour 1 - Orange
      {
          src: 'colour1',
          colour: 'rgba(252,115,49,0.2)'
      },

      // Colour 2 - Pink
      {
          src: 'colour2',
          colour: 'rgba(236,0,140,0.2)'
      },

      // Colour 3 - Yellow
      {
          src: 'colour3',
          colour: 'rgba(241,196,15,0.2)'
      },

      // Colour 4 - Green
      {
          src: 'colour4',
          colour: 'rgba(95,178,106,0.2)'
      },

      // Colour 5 - Blue
      {
          src: 'colour5',
          colour: 'rgba(113,137,255,0.2)'
      }
  ];

  //Use set interval to go through our colourArray
  //Each interval change the background colour of the element
  //Plugin is on, and increment the index.
  setInterval(function() {
    //Change background of selected $element to be
    //colourArray[index]
    //Increment index
    index = index + 1;
    //Make sure that index is not larger than the length of the colourArray
    //If so,
  },5000);

  // Create a style tag
  var style = $("<style>");

  for (var i = 0; i < colourArray.length; i++) {

    // Append a CSS rule to the style tag
    var currentColour = colourArray[i];
    var colorStyle =  " ."+currentColour.src+ " { background: "+currentColour.colour+" !important;} \n\n";

    style.append(colorStyle);
    // console.log(colourArray[i]);

  }; // end for loop

  var c = 0;
  var currentColour = setInterval(function(){
    // setColor();
    var className = colourArray[c].src;
    $('#spectrumPlugin').removeClass().addClass(className + ' spectrumHeader navbar navbar-default navbar-fixed-top');
    c++;

    if(c === colourArray.length) {
      c = 0;
    }

  }, 5000);

  // Appends the style tag in the body of the HTML document
  $('body').append(style);

});