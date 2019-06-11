import Rails from 'rails-ujs';
import Vue from 'vue'
import ToastMessage from '../components/toastMessage';

Rails.start()

new Vue({
  el: '#toast-messages',
  components: {
    ToastMessage
  }
})
