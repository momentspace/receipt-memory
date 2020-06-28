<template>
  <v-row>
    <v-col>
      <v-card>
        <v-card-title class="headline">{{titleText}}</v-card-title>
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-card-text>
            <v-text-field
              label="説明"
              prependIcon="mdi-text"
              placeholder="アップロードする画像の説明"
              v-model="description"
            />

            <v-select
            v-model="selectItem"
              prepend-icon="mdi-shape"
              :items=itemCategories
              label="科目を選択してください">
            </v-select>

            <v-file-input
              :rules="fileRules"
              accept="image/png, image/jpeg"
              label="image file"
              placeholder="アップロードするレシートを選択してください"
              prepend-icon="mdi-camera"
              :clearable="true"
              :show-size="true"
              :counter="true"
              required
              v-model="file"
            />

            <v-menu
              v-model="calendar"
              :nudge-right="70"
              transition="scale-transition"
              offset-y
              min-width="290px"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-text-field
                  v-model="purchasedAt"
                  label="購入日を選択してください"
                  prepend-icon="mdi-calendar-month"
                  readonly
                  v-bind="attrs"
                  v-on="on"
                ></v-text-field>
              </template>
              <v-date-picker v-model="purchasedAt" @input="calendar = false"></v-date-picker>
            </v-menu>
          </v-card-text>

          <v-card-actions>
            <v-spacer />
            <v-btn :disabled="!valid" color="primary" @click="upload">upload</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
export default {
  // model: {
  // prop: uploadFile,
  // event: upload
  // },
  components: {},
  props: ["uploadAction", "maxSize", "title", "categories"],
  data() {
    return {
      valid: false,
      file: null,
      fileRules: [
        value => {
          if (value && this.isImage(value.type) && this.rangeSize(value.size)) {
            return true;
          }
          return false;
        }
      ],
      description: "",
      //purchasedAt: new Date(),
      purchasedAt: "",
      calendar: "",
      selectItem: ""
    };
  },
  computed: {
    titleText: function() {
      return !this.title ? "Receipt Upload Form" : this.title;
    },
    itemCategories: function() {
      return this.categories;
    }
  },
  mounted: function() {
    this.valid = false;
  },
  methods: {
    upload() {
      let result = this.$refs.form.validate();
      console.log(this.selectItem)
      const formdata = {
        description: this.description,
        file: this.file,
        category: this.selectItem,
        purchased_at: this.purchasedAt
      };
      this.uploadAction(formdata);
    },
    rangeSize(size) {
      return size < this.maxSize;
    },
    isImage(type) {
      return ["image/jpeg", "image/png"].includes(type);
    }
  }
};
</script>

