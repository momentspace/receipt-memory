<template>
  <v-card-text style="height: 100px; position: relative">
    <v-btn
      color="primary"
      dark
      fixed 
      bottom
      right
      fab
      @click="click"
    >
      <v-icon>mdi-plus</v-icon>
    </v-btn>
  </v-card-text>
</template>

<script>
export default {
  props: ["additionalClicked"],
  data() {
    return {

    }
  },
  methods: {
    click: function() {
      console.log("click")
      this.additionalClicked()
    }
  }
}
</script>