<template lang="pug">
span
</template>

<script>
import { toast } from "bulma-toast";

export default {
  props: ['type', 'msg'],
  created: function(){
    toast({
      message: this.msg,
      type: 'is-' + this.type,
      duration: 3000,
      animate: { in: 'fadeIn', out: 'fadeOut' }
    })
  }
}
</script>
