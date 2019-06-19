import Rails from 'rails-ujs';
import Vue from 'vue'
import Bulma from '@vizuaalog/bulmajs/src/core';
import ToastMessage from '../components/toastMessage';

Rails.start()

new Vue({
  el: '#toast-messages',
  components: {
    ToastMessage
  }
})

// Modal
document.onreadystatechange = () => {
  [].forEach.call(document.querySelectorAll('[aria-open-modal]'), function(btn){
    console.log(document.querySelector(btn.getAttribute('aria-open-modal')));
    var modal = Bulma.create('modal', {
      style: 'normal',
      element: document.querySelector(btn.getAttribute('aria-open-modal'))
    });
    btn.addEventListener('click', function(e){
      modal.open();
    });
  });
}
