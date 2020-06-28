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
      <UploadReceipt
        :uploadAction="upload"
        maxSize=5000000
        :categories=categories
      />
      <ReceiptList
        :deleteAction="deleteReceipt"
        v-bind:receipts=receipts
      />
    </v-container>
  </v-layout>
</template>

<script>
import UploadReceipt from "@/components/upload_receipt.vue";
import ReceiptList from "@/components/receipt_list.vue";
export default {
  components: {
    UploadReceipt,
    ReceiptList
  },
  data() {
    return {
      receipts: [],
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
      categories: [],
    }
  },
  mounted: function() {
    this.valid = false;
    this.initialize();
  },
  methods: {
    upload(formdata) {
      let data = new FormData();
      data.append("receipt[category]", formdata.selectItem);
      data.append("receipt[shop_id]", 1);
      data.append("receipt[editor_id]", 1);
      data.append("receipt[owner_id]", 1);
      data.append("receipt[purchased_at]", formdata.purchasedAt); 
      data.append("receipt[name]", formdata.description);
      data.append('receipt[image]', formdata.file);
      this.uploadReceipt(data)
    },
    deleteReceipt(id) {
      console.log("delete receipt");
      const url = `http://${location.hostname}:3100/api/v1/receipts/${id}`
      this.$axios.$delete(url).then((ret) => {
        this.receipts.forEach((e, i) => {
          if (e.id === ret.id) this.receipts.splice(i, 1)
        });
      })
    },
    async uploadReceipt(data) {
      const config = {
        headers: { contentType: "multipart/form-data" }
      }
      const url = `http://${location.hostname}:3100/api/v1/receipts/`
      const ret = await this.$axios.$post(url, data, config);
      this.receipts.unshift(ret)
      console.log(ret);
    },
    async initialize() {
      const urlReceipts = `http://${location.hostname}:3100/api/v1/receipts/`
      this.$axios.$get(urlReceipts).then((ret) => {
        console.log(ret);
        this.receipts = ret;
      })
      const url = `http://${location.hostname}:3100/api/v1/categories`
      this.$axios.$get(url).then((ret) => {
        console.log(ret['category']);
        // 形式変換
        const items = Object.entries(ret['category']).map(([key, value]) => {
          return {text: key, value: value}
        });
        console.log(items);
        this.categories = items;
      })
    },
  }
}
</script>
