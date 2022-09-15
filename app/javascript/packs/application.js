// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "packs/application.css";

import "jquery";
import "popper.js";
import "bootstrap";
import Chart from 'chart.js/auto';
import '@fortawesome/fontawesome-free/js/all'
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// グラフ
global.Chart = Chart;

// 感情アイコン
document.addEventListener("turbolinks:load", function(){
  let radio_btns = document.querySelectorAll(`input[type='radio'][class='hidden_radio']`);
  for (let target of radio_btns) {
    target.addEventListener(`change`, () => {
      document.querySelector('.check_radio').classList.remove('check_radio');
      document.querySelector(`label[for='${target.id}']`).classList.add('check_radio');
    });
  }
})
