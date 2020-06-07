<template>
  <v-dialog
    @input="$emit('change', false)"
    :value=visible
  >
    <v-card>
      <v-img
        :src=url
        @click="$emit('change', false)"
      />
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  model: {
    prop: 'visible',
    event: 'change'
  },
  components: {
  },
  props: ['url', 'visible'],
  data() {
    return {
    }
  },
  methods: {
  }
}
</script>
