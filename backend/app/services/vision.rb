require "google/cloud/vision"

class Vision
  def self.ocr(image)
    value = 0
    image_annotator = Google::Cloud::Vision.image_annotator
    response = image_annotator.text_detection image: filename
    response.responses.each do |res|
      p res.text_annotations.first.description
      sum_labels = (res.text_annotations.filter {|x|
        x.description.gsub(/[\s　]/, '') == "合" || x.description.gsub(/[\s　]/, '') == "合計" }
      )
      sum_values = res.text_annotations.filter do |x|
        sum_labels.any? do |label|
          y = label.bounding_poly.vertices.first.y
          y - 5 <= x.bounding_poly.vertices.first.y && x.bounding_poly.vertices.first.y <= y + 5
        end
      end
      values = sum_values.filter {|v| !!(v.description =~ /^[0-9,.]+$/) }
      values = values.map {|v| v.description.gsub(/[,.]/, "").to_i }
      value = values.max.nil? ? 0 : values.max
    end
    return value
  end
end