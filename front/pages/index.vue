<template>
  <v-layout
    column
    justify-center
    align-center
  >
    <v-container
      md-10
      sm-10
      xs-12
    >
      <UploadImage
        :uploadAction="upload"
        maxSize=5000000
      />
      <ReceiptList
        :deleteAction="deleteImage"
        v-bind:receipts=images
      />
    </v-container>
  </v-layout>
</template>

<script>
import UploadImage from "@/components/upload_image.vue";
import ReceiptList from "@/components/receipt_list.vue";
export default {
  components: {
    UploadImage,
    ReceiptList
  },
  data() {
    return {
      images: [],
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
    }
  },
  mounted: function() {
    this.valid = false;
    this.initialize();
  },
  methods: {
    upload(description, file) {
      let data = new FormData();
      data.append("image[description]", description);
      data.append('image[data]', file);
      this.uploadImage(data)
    },
    deleteImage(id) {
      console.log("delete image");
      const url = `http://${location.hostname}:3100/api/v1/images/${id}`
      this.$axios.$delete(url).then((ret) => {
        this.images.forEach((e, i) => {
          if (e.id === ret.id) this.images.splice(i, 1)
        });
      })
    },
    async uploadImage(data) {
      const config = {
        headers: { contentType: "multipart/form-data" }
      }
      const url = `http://${location.hostname}:3100/api/v1/images/`
      const ret = await this.$axios.$post(url, data, config);
      this.images.unshift(ret)
      console.log(ret);
    },
    async initialize() {
      const url = `http://${location.hostname}:3100/api/v1/images/`
      this.$axios.$get(url).then((ret) => {
        console.log(ret);
        this.images = ret;
      })
    },
  }
}
</script>
