<template>
  <v-lazy
    v-model="isActive"
    :options="{
      threshold: .5
    }"
    min-height="200"
    transition="scale-transition"
  >
    <v-card
      class="pa-2"
      outlined
      tile
    >
      <v-list-item>
        <v-list-item-avatar color="grey"></v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title class="headline">{{description}}</v-list-item-title>
          <v-list-item-subtitle>by anonymous</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>

      <v-list-item>
        <v-list-item-content>
          <v-card-text>
            ここに画像に関する複数のパラメータを表示するようにする
          </v-card-text>
          <v-card-text/>
          <v-card-text/>
        </v-list-item-content>

        <v-list-item-avatar
          tile
          size=150
          color=grey
        >
          <v-img
          id="test"
            :src=url_thumb
            hover
            @click="$emit('click', url)"
          ></v-img>
        </v-list-item-avatar>
      </v-list-item>


      <v-card-actions>
        <v-btn>
          Edit
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn
          icon
          @click=deleteClick(id)
        >
          <v-icon>mdi-trash-can-outline</v-icon>
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-lazy>
</template>

<script>
export default {
  model: {
    prop: "src",
    event: "click"
  },
  components: {
  },
  props: ['id', 'url', 'url_thumb', 'description', 'deleteAction'],
  data() {
    return {
      isActive: false,
    }
  },
  mounted: function() {
  },
  methods: {
    async deleteClick(id) {
      const ret = await this.$confirm('指定ファイルを削除しますよ？');
      if (ret) this.deleteAction(id)
    }
  }
}
</script>
