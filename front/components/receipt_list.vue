<template>
  <v-container>
    <v-row id="v-for-receipt">
      <v-col
        xs=12
        sm=12
        md=6
        lg=6
        xl=4
        v-for="receipt in receipts" :key="receipt.id">
        <v-card
          hover
        >
          <ReceiptImage 
            v-bind=receipt
            @click=imageClicked
            :deleteAction=deleteAction
          />
        </v-card>
      </v-col>
    </v-row>
    <ImagePopup
      :url=imgUrl
      v-model=visible
    />
  </v-container>
</template>

<script>
import ReceiptImage from "@/components/receipt_image";
import ImagePopup from '@/components/image_popup';
export default {
  props: ["receipts", "deleteAction"],
  components: {
    ReceiptImage,
    ImagePopup 
  },
  data() {
    return {
      visible: false,
      imgUrl: "",
    }
  },
  computed: {
  },
  mounted: function() {
  },
  methods: {
    imageClicked(url) {
      this.imgUrl = url;
      this.visible = true;
    },
  },
}
</script>
