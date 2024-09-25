'use strict';
window.onload = init;
function init() {
document.getElementById('btn').onclick = validate;
document.getElementById('btnclr').onclick = clear;
}
function validate() {
var radios = document.getElementById("quiz").getElementsByTagName("INPUT");
var right = 0;
var wrong = 0;
for(var i=0, len=radios.length ; i<len ; i++){
  if(radios[i].value == "x") {
    if(radios[i].checked == true) {
      right++;
      radios[i].parentNode.parentNode.className = 'rightans';
    }
    else{
      wrong++;
      radios[i].parentNode.parentNode.className = 'wrongans';
    }
  }
}
var pcnt = (100*right/(wrong+right)).toFixed(1);document.getElementById("score").innerHTML = 'Correct: '+ right +'<br>Incorrect: ' + wrong +'<br>Percent Correct: ' + pcnt +'%';
}
function clear(){
var radios = document.getElementById("quiz").getElementsByTagName("INPUT");
for(var i=0, len=radios.length ; i<len ; i++){
    radios[i].checked = false;
    if (radios[i].value == "x"){
        radios[i].parentNode.parentNode.className = '';
    }
}
document.getElementById("score").innerHTML = '';
}
