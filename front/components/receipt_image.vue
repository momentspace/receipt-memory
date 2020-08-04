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
          <v-list-item-title class="headline">{{name}}</v-list-item-title>
          <v-list-item-subtitle>by anonymous</v-list-item-subtitle>
        </v-list-item-content>
        <div class="caption"><span class="blue--text text--lighten-2">{{category_text}}</span></div>
      </v-list-item>

      <v-list-item>
        <v-list-item-content>
          <v-card-text>
            {{name}}
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
            :src=url_thumb
            hover
            @click="$emit('click', url)"
          ></v-img>
        </v-list-item-avatar>
      </v-list-item>


      <v-card-actions>
        <div class="caption"><span class="grey--text text--darken-1">{{purchasedDate}}</span></div>
        <v-spacer></v-spacer>
        <v-btn
          icon
          @click=editClick(id)
        >
          <v-icon>mdi-pencil-outline</v-icon>
        </v-btn>
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
  props: ['id', 'url', 'url_thumb', 'name', 'category', 'category_text', 'purchased_at', 'deleteAction'],
  data() {
    return {
      isActive: false,
    }
  },
  computed: {
    purchasedDate: function() {
      return this.purchased_at
      // return this.$dateFns.format(this.$dateFns.parse(this.purchased_at), "yyyy-MM-dd");
    }
  },
  mounted: function() {
  },
  methods: {
    editClick(id) {

    },
    async deleteClick(id) {
      const ret = await this.$confirm('指定ファイルを削除しますよ？');
      if (ret) this.deleteAction(id)
    }
  }
}
</script>
