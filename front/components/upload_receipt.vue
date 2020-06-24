<template>
  <v-row>
    <v-col>
      <v-card>
        <v-card-title class="headline">
          {{titleText}}
        </v-card-title>
        <v-form
          ref="form"
          v-model="valid"
          lazy-validation
        >
          <v-card-text>
            <v-text-field
              label="説明"
              prependIcon="mdi-text"
              placeholder="アップロードする画像の説明"
              v-model=description
            />
            <v-file-input
              :rules=fileRules
              accept="image/png, image/jpeg"
              label="image file"
              placeholder="アップロードする画像を選択してください"
              prepend-icon="mdi-camera"
              :clearable=true
              :show-size=true
              :counter=true
              required
              v-model=file
            />
          </v-card-text>
          <v-card-actions>
            <v-spacer />
            <v-btn
              :disabled="!valid"
              color="primary"
              @click="upload"
            >
              upload
            </v-btn>
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
  components: {
  },
  props: ["uploadAction", "maxSize", "title"],
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
    }
  },
  computed: {
    titleText: function() {
      return !this.title ? "Receipt Upload Form" : this.title
    }
  },
  mounted: function() {
    this.valid = false;
  },
  methods: {
    upload() {
      let result = this.$refs.form.validate();
      const formdata = {description: this.description, file: this.file}
      this.uploadAction(formdata);
    },
    rangeSize(size) {
      return size < this.maxSize;
    },
    isImage(type) {
      return ["image/jpeg", "image/png"].includes(type);
    },
  }
}
</script>

